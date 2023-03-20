
_schdtest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}
#endif

int
main(int argc, char *argv[])
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
    test_case_1();
       6:	e8 e5 01 00 00       	call   1f0 <test_case_1>
    test_case_2();
       b:	e8 40 03 00 00       	call   350 <test_case_2>
    test_case_3();
      10:	e8 bb 04 00 00       	call   4d0 <test_case_3>
    test_case_4();
      15:	e8 26 07 00 00       	call   740 <test_case_4>
    test_case_5();
      1a:	e8 91 08 00 00       	call   8b0 <test_case_5>
    //test_case_6();
    
    exit(); // main process terminates
      1f:	e8 3f 0c 00 00       	call   c63 <exit>
      24:	66 90                	xchg   %ax,%ax
      26:	66 90                	xchg   %ax,%ax
      28:	66 90                	xchg   %ax,%ax
      2a:	66 90                	xchg   %ax,%ax
      2c:	66 90                	xchg   %ax,%ax
      2e:	66 90                	xchg   %ax,%ax

00000030 <do_child>:
    unsigned int tmp = 0;
      30:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
      32:	31 c0                	xor    %eax,%eax
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmp += cnt;
      38:	01 c2                	add    %eax,%edx
        cnt ++;
      3a:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
      3d:	3d 00 00 00 10       	cmp    $0x10000000,%eax
      42:	75 f4                	jne    38 <do_child+0x8>
    avoid_optm = tmp;
      44:	89 15 e4 18 00 00    	mov    %edx,0x18e4
}
      4a:	c3                   	ret    
      4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      4f:	90                   	nop

00000050 <do_parent>:
      50:	31 d2                	xor    %edx,%edx
      52:	31 c0                	xor    %eax,%eax
      54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      58:	01 c2                	add    %eax,%edx
      5a:	83 c0 01             	add    $0x1,%eax
      5d:	3d 00 00 00 10       	cmp    $0x10000000,%eax
      62:	75 f4                	jne    58 <do_parent+0x8>
      64:	89 15 e4 18 00 00    	mov    %edx,0x18e4
      6a:	c3                   	ret    
      6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      6f:	90                   	nop

00000070 <do_parent_partial>:
    unsigned int tmp = 0;
      70:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
      72:	31 c0                	xor    %eax,%eax
      74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmp += cnt;
      78:	01 c2                	add    %eax,%edx
        cnt ++;
      7a:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT/2)
      7d:	3d 00 00 00 08       	cmp    $0x8000000,%eax
      82:	75 f4                	jne    78 <do_parent_partial+0x8>
    avoid_optm = tmp;
      84:	89 15 e4 18 00 00    	mov    %edx,0x18e4
}
      8a:	c3                   	ret    
      8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      8f:	90                   	nop

00000090 <create_child_process>:
{
      90:	55                   	push   %ebp
      91:	89 e5                	mov    %esp,%ebp
      93:	56                   	push   %esi
      94:	8b 45 08             	mov    0x8(%ebp),%eax
      97:	53                   	push   %ebx
    int child_cnt = cnt > MAX_CHILD_COUNT ? MAX_CHILD_COUNT : cnt;
      98:	bb 06 00 00 00       	mov    $0x6,%ebx
      9d:	83 f8 06             	cmp    $0x6,%eax
      a0:	0f 4e d8             	cmovle %eax,%ebx
    for (i = 0; i < child_cnt; i++)
      a3:	85 c0                	test   %eax,%eax
      a5:	7e 22                	jle    c9 <create_child_process+0x39>
      a7:	31 f6                	xor    %esi,%esi
      a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        child[i].pid = fork();
      b0:	e8 a6 0b 00 00       	call   c5b <fork>
      b5:	89 04 b5 e8 18 00 00 	mov    %eax,0x18e8(,%esi,4)
        if (child[i].pid < 0)
      bc:	85 c0                	test   %eax,%eax
      be:	78 10                	js     d0 <create_child_process+0x40>
        else if (child[i].pid == 0) // child
      c0:	74 22                	je     e4 <create_child_process+0x54>
    for (i = 0; i < child_cnt; i++)
      c2:	83 c6 01             	add    $0x1,%esi
      c5:	39 f3                	cmp    %esi,%ebx
      c7:	7f e7                	jg     b0 <create_child_process+0x20>
}
      c9:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cc:	5b                   	pop    %ebx
      cd:	5e                   	pop    %esi
      ce:	5d                   	pop    %ebp
      cf:	c3                   	ret    
            printf(1, "fork() failed!\n");
      d0:	83 ec 08             	sub    $0x8,%esp
      d3:	68 58 11 00 00       	push   $0x1158
      d8:	6a 01                	push   $0x1
      da:	e8 11 0d 00 00       	call   df0 <printf>
            exit();
      df:	e8 7f 0b 00 00       	call   c63 <exit>
    unsigned int tmp = 0;
      e4:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
      e6:	31 c0                	xor    %eax,%eax
      e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ef:	90                   	nop
        tmp += cnt;
      f0:	01 c2                	add    %eax,%edx
        cnt ++;
      f2:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
      f5:	3d 00 00 00 10       	cmp    $0x10000000,%eax
      fa:	75 f4                	jne    f0 <create_child_process+0x60>
    avoid_optm = tmp;
      fc:	89 15 e4 18 00 00    	mov    %edx,0x18e4
            exit();
     102:	e8 5c 0b 00 00       	call   c63 <exit>
     107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     10e:	66 90                	xchg   %ax,%ax

00000110 <print_proc_tickets>:
{
     110:	55                   	push   %ebp
     111:	89 e5                	mov    %esp,%ebp
     113:	57                   	push   %edi
     114:	56                   	push   %esi
    int child_cnt = cnt > MAX_CHILD_COUNT ? MAX_CHILD_COUNT : cnt;
     115:	be 06 00 00 00       	mov    $0x6,%esi
{
     11a:	53                   	push   %ebx
     11b:	83 ec 0c             	sub    $0xc,%esp
     11e:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int child_cnt = cnt > MAX_CHILD_COUNT ? MAX_CHILD_COUNT : cnt;
     121:	83 fb 06             	cmp    $0x6,%ebx
     124:	0f 4e f3             	cmovle %ebx,%esi
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     127:	e8 b7 0b 00 00       	call   ce3 <getpid>
     12c:	83 ec 0c             	sub    $0xc,%esp
     12f:	50                   	push   %eax
     130:	e8 ee 0b 00 00       	call   d23 <tickets_owned>
     135:	89 c7                	mov    %eax,%edi
     137:	e8 a7 0b 00 00       	call   ce3 <getpid>
     13c:	57                   	push   %edi
     13d:	50                   	push   %eax
     13e:	68 88 11 00 00       	push   $0x1188
     143:	6a 01                	push   $0x1
     145:	e8 a6 0c 00 00       	call   df0 <printf>
    for (i = 0; i < child_cnt; i++)
     14a:	83 c4 20             	add    $0x20,%esp
     14d:	85 db                	test   %ebx,%ebx
     14f:	7e 34                	jle    185 <print_proc_tickets+0x75>
     151:	31 db                	xor    %ebx,%ebx
     153:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     157:	90                   	nop
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     158:	83 ec 0c             	sub    $0xc,%esp
     15b:	ff 34 9d e8 18 00 00 	pushl  0x18e8(,%ebx,4)
     162:	e8 bc 0b 00 00       	call   d23 <tickets_owned>
     167:	50                   	push   %eax
     168:	ff 34 9d e8 18 00 00 	pushl  0x18e8(,%ebx,4)
    for (i = 0; i < child_cnt; i++)
     16f:	83 c3 01             	add    $0x1,%ebx
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     172:	68 ac 11 00 00       	push   $0x11ac
     177:	6a 01                	push   $0x1
     179:	e8 72 0c 00 00       	call   df0 <printf>
    for (i = 0; i < child_cnt; i++)
     17e:	83 c4 20             	add    $0x20,%esp
     181:	39 de                	cmp    %ebx,%esi
     183:	7f d3                	jg     158 <print_proc_tickets+0x48>
}
     185:	8d 65 f4             	lea    -0xc(%ebp),%esp
     188:	5b                   	pop    %ebx
     189:	5e                   	pop    %esi
     18a:	5f                   	pop    %edi
     18b:	5d                   	pop    %ebp
     18c:	c3                   	ret    
     18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <wait_on_child_processes>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	56                   	push   %esi
    int child_cnt = cnt > MAX_CHILD_COUNT ? MAX_CHILD_COUNT : cnt;
     194:	be 06 00 00 00       	mov    $0x6,%esi
{
     199:	8b 45 08             	mov    0x8(%ebp),%eax
     19c:	53                   	push   %ebx
    int child_cnt = cnt > MAX_CHILD_COUNT ? MAX_CHILD_COUNT : cnt;
     19d:	83 f8 06             	cmp    $0x6,%eax
     1a0:	0f 4e f0             	cmovle %eax,%esi
    for (i = 0; i < child_cnt; i++)
     1a3:	85 c0                	test   %eax,%eax
     1a5:	7e 33                	jle    1da <wait_on_child_processes+0x4a>
     1a7:	31 db                	xor    %ebx,%ebx
     1a9:	eb 0c                	jmp    1b7 <wait_on_child_processes+0x27>
     1ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1af:	90                   	nop
     1b0:	83 c3 01             	add    $0x1,%ebx
     1b3:	39 de                	cmp    %ebx,%esi
     1b5:	7e 23                	jle    1da <wait_on_child_processes+0x4a>
       if (wait() < 0)
     1b7:	e8 af 0a 00 00       	call   c6b <wait>
     1bc:	85 c0                	test   %eax,%eax
     1be:	79 f0                	jns    1b0 <wait_on_child_processes+0x20>
            printf(1, "\nwait() on child-%d failed!\n", i);
     1c0:	83 ec 04             	sub    $0x4,%esp
     1c3:	53                   	push   %ebx
    for (i = 0; i < child_cnt; i++)
     1c4:	83 c3 01             	add    $0x1,%ebx
            printf(1, "\nwait() on child-%d failed!\n", i);
     1c7:	68 68 11 00 00       	push   $0x1168
     1cc:	6a 01                	push   $0x1
     1ce:	e8 1d 0c 00 00       	call   df0 <printf>
     1d3:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < child_cnt; i++)
     1d6:	39 de                	cmp    %ebx,%esi
     1d8:	7f dd                	jg     1b7 <wait_on_child_processes+0x27>
}
     1da:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1dd:	5b                   	pop    %ebx
     1de:	5e                   	pop    %esi
     1df:	5d                   	pop    %ebp
     1e0:	c3                   	ret    
     1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     1e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     1ef:	90                   	nop

000001f0 <test_case_1>:
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	53                   	push   %ebx
    for (i = 0; i < child_cnt; i++)
     1f4:	31 db                	xor    %ebx,%ebx
{
     1f6:	83 ec 08             	sub    $0x8,%esp
    printf(1, "===== Test case 1: default (RR) scheduler, %d child processes =====\n", child_cnt);
     1f9:	6a 03                	push   $0x3
     1fb:	68 cc 11 00 00       	push   $0x11cc
     200:	6a 01                	push   $0x1
     202:	e8 e9 0b 00 00       	call   df0 <printf>
    set_sched(scheduler);
     207:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     20e:	e8 08 0b 00 00       	call   d1b <set_sched>
     213:	83 c4 10             	add    $0x10,%esp
     216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     21d:	8d 76 00             	lea    0x0(%esi),%esi
        child[i].pid = fork();
     220:	e8 36 0a 00 00       	call   c5b <fork>
     225:	89 04 9d e8 18 00 00 	mov    %eax,0x18e8(,%ebx,4)
        if (child[i].pid < 0)
     22c:	85 c0                	test   %eax,%eax
     22e:	0f 88 e8 00 00 00    	js     31c <test_case_1+0x12c>
        else if (child[i].pid == 0) // child
     234:	0f 84 f6 00 00 00    	je     330 <test_case_1+0x140>
    for (i = 0; i < child_cnt; i++)
     23a:	83 c3 01             	add    $0x1,%ebx
     23d:	83 fb 03             	cmp    $0x3,%ebx
     240:	75 de                	jne    220 <test_case_1+0x30>
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     242:	e8 9c 0a 00 00       	call   ce3 <getpid>
     247:	83 ec 0c             	sub    $0xc,%esp
     24a:	50                   	push   %eax
     24b:	e8 d3 0a 00 00       	call   d23 <tickets_owned>
     250:	89 c3                	mov    %eax,%ebx
     252:	e8 8c 0a 00 00       	call   ce3 <getpid>
     257:	53                   	push   %ebx
    for (i = 0; i < child_cnt; i++)
     258:	31 db                	xor    %ebx,%ebx
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     25a:	50                   	push   %eax
     25b:	68 88 11 00 00       	push   $0x1188
     260:	6a 01                	push   $0x1
     262:	e8 89 0b 00 00       	call   df0 <printf>
     267:	83 c4 20             	add    $0x20,%esp
     26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     270:	83 ec 0c             	sub    $0xc,%esp
     273:	ff 34 9d e8 18 00 00 	pushl  0x18e8(,%ebx,4)
     27a:	e8 a4 0a 00 00       	call   d23 <tickets_owned>
     27f:	50                   	push   %eax
     280:	ff 34 9d e8 18 00 00 	pushl  0x18e8(,%ebx,4)
    for (i = 0; i < child_cnt; i++)
     287:	83 c3 01             	add    $0x1,%ebx
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     28a:	68 ac 11 00 00       	push   $0x11ac
     28f:	6a 01                	push   $0x1
     291:	e8 5a 0b 00 00       	call   df0 <printf>
    for (i = 0; i < child_cnt; i++)
     296:	83 c4 20             	add    $0x20,%esp
     299:	83 fb 03             	cmp    $0x3,%ebx
     29c:	75 d2                	jne    270 <test_case_1+0x80>
    enable_sched_trace(1);
     29e:	83 ec 0c             	sub    $0xc,%esp
     2a1:	6a 01                	push   $0x1
     2a3:	e8 63 0a 00 00       	call   d0b <enable_sched_trace>
     2a8:	83 c4 10             	add    $0x10,%esp
    unsigned int tmp = 0;
     2ab:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     2ad:	31 c0                	xor    %eax,%eax
     2af:	90                   	nop
        tmp += cnt;
     2b0:	01 c2                	add    %eax,%edx
        cnt ++;
     2b2:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     2b5:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     2ba:	75 f4                	jne    2b0 <test_case_1+0xc0>
    avoid_optm = tmp;
     2bc:	89 15 e4 18 00 00    	mov    %edx,0x18e4
    for (i = 0; i < child_cnt; i++)
     2c2:	31 db                	xor    %ebx,%ebx
     2c4:	eb 12                	jmp    2d8 <test_case_1+0xe8>
     2c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     2cd:	8d 76 00             	lea    0x0(%esi),%esi
     2d0:	83 c3 01             	add    $0x1,%ebx
     2d3:	83 fb 03             	cmp    $0x3,%ebx
     2d6:	74 24                	je     2fc <test_case_1+0x10c>
       if (wait() < 0)
     2d8:	e8 8e 09 00 00       	call   c6b <wait>
     2dd:	85 c0                	test   %eax,%eax
     2df:	79 ef                	jns    2d0 <test_case_1+0xe0>
            printf(1, "\nwait() on child-%d failed!\n", i);
     2e1:	83 ec 04             	sub    $0x4,%esp
     2e4:	53                   	push   %ebx
    for (i = 0; i < child_cnt; i++)
     2e5:	83 c3 01             	add    $0x1,%ebx
            printf(1, "\nwait() on child-%d failed!\n", i);
     2e8:	68 68 11 00 00       	push   $0x1168
     2ed:	6a 01                	push   $0x1
     2ef:	e8 fc 0a 00 00       	call   df0 <printf>
     2f4:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < child_cnt; i++)
     2f7:	83 fb 03             	cmp    $0x3,%ebx
     2fa:	75 dc                	jne    2d8 <test_case_1+0xe8>
    enable_sched_trace(0);
     2fc:	83 ec 0c             	sub    $0xc,%esp
     2ff:	6a 00                	push   $0x0
     301:	e8 05 0a 00 00       	call   d0b <enable_sched_trace>
    printf(1, "\n\n");      
     306:	58                   	pop    %eax
     307:	5a                   	pop    %edx
     308:	68 85 11 00 00       	push   $0x1185
     30d:	6a 01                	push   $0x1
     30f:	e8 dc 0a 00 00       	call   df0 <printf>
}
     314:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     317:	83 c4 10             	add    $0x10,%esp
     31a:	c9                   	leave  
     31b:	c3                   	ret    
            printf(1, "fork() failed!\n");
     31c:	83 ec 08             	sub    $0x8,%esp
     31f:	68 58 11 00 00       	push   $0x1158
     324:	6a 01                	push   $0x1
     326:	e8 c5 0a 00 00       	call   df0 <printf>
            exit();
     32b:	e8 33 09 00 00       	call   c63 <exit>
    unsigned int tmp = 0;
     330:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     332:	31 c0                	xor    %eax,%eax
     334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        tmp += cnt;
     338:	01 c2                	add    %eax,%edx
        cnt ++;
     33a:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     33d:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     342:	75 f4                	jne    338 <test_case_1+0x148>
    avoid_optm = tmp;
     344:	89 15 e4 18 00 00    	mov    %edx,0x18e4
            exit();
     34a:	e8 14 09 00 00       	call   c63 <exit>
     34f:	90                   	nop

00000350 <test_case_2>:
{
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	53                   	push   %ebx
     354:	83 ec 0c             	sub    $0xc,%esp
    printf(1, "===== Test case 2: stride scheduler, %d child processes, no ticket trasfer =====\n");
     357:	68 14 12 00 00       	push   $0x1214
     35c:	6a 01                	push   $0x1
     35e:	e8 8d 0a 00 00       	call   df0 <printf>
    set_sched(scheduler);
     363:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     36a:	e8 ac 09 00 00       	call   d1b <set_sched>
        child[i].pid = fork();
     36f:	e8 e7 08 00 00       	call   c5b <fork>
        if (child[i].pid < 0)
     374:	83 c4 10             	add    $0x10,%esp
        child[i].pid = fork();
     377:	a3 e8 18 00 00       	mov    %eax,0x18e8
        if (child[i].pid < 0)
     37c:	85 c0                	test   %eax,%eax
     37e:	0f 88 13 01 00 00    	js     497 <test_case_2+0x147>
        else if (child[i].pid == 0) // child
     384:	0f 84 21 01 00 00    	je     4ab <test_case_2+0x15b>
        child[i].pid = fork();
     38a:	e8 cc 08 00 00       	call   c5b <fork>
     38f:	a3 ec 18 00 00       	mov    %eax,0x18ec
        if (child[i].pid < 0)
     394:	85 c0                	test   %eax,%eax
     396:	0f 88 fb 00 00 00    	js     497 <test_case_2+0x147>
        else if (child[i].pid == 0) // child
     39c:	0f 84 09 01 00 00    	je     4ab <test_case_2+0x15b>
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     3a2:	e8 3c 09 00 00       	call   ce3 <getpid>
     3a7:	83 ec 0c             	sub    $0xc,%esp
     3aa:	50                   	push   %eax
     3ab:	e8 73 09 00 00       	call   d23 <tickets_owned>
     3b0:	89 c3                	mov    %eax,%ebx
     3b2:	e8 2c 09 00 00       	call   ce3 <getpid>
     3b7:	53                   	push   %ebx
     3b8:	50                   	push   %eax
     3b9:	68 88 11 00 00       	push   $0x1188
     3be:	6a 01                	push   $0x1
     3c0:	e8 2b 0a 00 00       	call   df0 <printf>
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     3c5:	83 c4 14             	add    $0x14,%esp
     3c8:	ff 35 e8 18 00 00    	pushl  0x18e8
     3ce:	e8 50 09 00 00       	call   d23 <tickets_owned>
     3d3:	50                   	push   %eax
     3d4:	ff 35 e8 18 00 00    	pushl  0x18e8
     3da:	68 ac 11 00 00       	push   $0x11ac
     3df:	6a 01                	push   $0x1
     3e1:	e8 0a 0a 00 00       	call   df0 <printf>
     3e6:	83 c4 14             	add    $0x14,%esp
     3e9:	ff 35 ec 18 00 00    	pushl  0x18ec
     3ef:	e8 2f 09 00 00       	call   d23 <tickets_owned>
     3f4:	50                   	push   %eax
     3f5:	ff 35 ec 18 00 00    	pushl  0x18ec
     3fb:	68 ac 11 00 00       	push   $0x11ac
     400:	6a 01                	push   $0x1
     402:	e8 e9 09 00 00       	call   df0 <printf>
    enable_sched_trace(1);
     407:	83 c4 14             	add    $0x14,%esp
     40a:	6a 01                	push   $0x1
     40c:	e8 fa 08 00 00       	call   d0b <enable_sched_trace>
     411:	83 c4 10             	add    $0x10,%esp
    unsigned int tmp = 0;
     414:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     416:	31 c0                	xor    %eax,%eax
     418:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     41f:	90                   	nop
        tmp += cnt;
     420:	01 c2                	add    %eax,%edx
        cnt ++;
     422:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     425:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     42a:	75 f4                	jne    420 <test_case_2+0xd0>
    avoid_optm = tmp;
     42c:	89 15 e4 18 00 00    	mov    %edx,0x18e4
       if (wait() < 0)
     432:	e8 34 08 00 00       	call   c6b <wait>
     437:	85 c0                	test   %eax,%eax
     439:	78 29                	js     464 <test_case_2+0x114>
     43b:	e8 2b 08 00 00       	call   c6b <wait>
     440:	85 c0                	test   %eax,%eax
     442:	78 3d                	js     481 <test_case_2+0x131>
    enable_sched_trace(0);
     444:	83 ec 0c             	sub    $0xc,%esp
     447:	6a 00                	push   $0x0
     449:	e8 bd 08 00 00       	call   d0b <enable_sched_trace>
    printf(1, "\n\n");
     44e:	58                   	pop    %eax
     44f:	5a                   	pop    %edx
     450:	68 85 11 00 00       	push   $0x1185
     455:	6a 01                	push   $0x1
     457:	e8 94 09 00 00       	call   df0 <printf>
}
     45c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     45f:	83 c4 10             	add    $0x10,%esp
     462:	c9                   	leave  
     463:	c3                   	ret    
            printf(1, "\nwait() on child-%d failed!\n", i);
     464:	83 ec 04             	sub    $0x4,%esp
     467:	6a 00                	push   $0x0
     469:	68 68 11 00 00       	push   $0x1168
     46e:	6a 01                	push   $0x1
     470:	e8 7b 09 00 00       	call   df0 <printf>
     475:	83 c4 10             	add    $0x10,%esp
       if (wait() < 0)
     478:	e8 ee 07 00 00       	call   c6b <wait>
     47d:	85 c0                	test   %eax,%eax
     47f:	79 c3                	jns    444 <test_case_2+0xf4>
            printf(1, "\nwait() on child-%d failed!\n", i);
     481:	83 ec 04             	sub    $0x4,%esp
     484:	6a 01                	push   $0x1
     486:	68 68 11 00 00       	push   $0x1168
     48b:	6a 01                	push   $0x1
     48d:	e8 5e 09 00 00       	call   df0 <printf>
     492:	83 c4 10             	add    $0x10,%esp
     495:	eb ad                	jmp    444 <test_case_2+0xf4>
            printf(1, "fork() failed!\n");
     497:	83 ec 08             	sub    $0x8,%esp
     49a:	68 58 11 00 00       	push   $0x1158
     49f:	6a 01                	push   $0x1
     4a1:	e8 4a 09 00 00       	call   df0 <printf>
            exit();
     4a6:	e8 b8 07 00 00       	call   c63 <exit>
    unsigned int tmp = 0;
     4ab:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     4ad:	31 c0                	xor    %eax,%eax
     4af:	90                   	nop
        tmp += cnt;
     4b0:	01 c2                	add    %eax,%edx
        cnt ++;
     4b2:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     4b5:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     4ba:	75 f4                	jne    4b0 <test_case_2+0x160>
    avoid_optm = tmp;
     4bc:	89 15 e4 18 00 00    	mov    %edx,0x18e4
            exit();
     4c2:	e8 9c 07 00 00       	call   c63 <exit>
     4c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4ce:	66 90                	xchg   %ax,%ax

000004d0 <test_case_3>:
{
     4d0:	55                   	push   %ebp
     4d1:	89 e5                	mov    %esp,%ebp
     4d3:	57                   	push   %edi
     4d4:	56                   	push   %esi
     4d5:	53                   	push   %ebx
     4d6:	83 ec 14             	sub    $0x14,%esp
    printf(1, "===== Test case 3: stride scheduler, testing return values of transfer_tickets() ... \n");
     4d9:	68 68 12 00 00       	push   $0x1268
     4de:	6a 01                	push   $0x1
     4e0:	e8 0b 09 00 00       	call   df0 <printf>
    set_sched(scheduler);
     4e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     4ec:	e8 2a 08 00 00       	call   d1b <set_sched>
        child[i].pid = fork();
     4f1:	e8 65 07 00 00       	call   c5b <fork>
        if (child[i].pid < 0)
     4f6:	83 c4 10             	add    $0x10,%esp
        child[i].pid = fork();
     4f9:	a3 e8 18 00 00       	mov    %eax,0x18e8
        if (child[i].pid < 0)
     4fe:	85 c0                	test   %eax,%eax
     500:	0f 88 fd 01 00 00    	js     703 <test_case_3+0x233>
        else if (child[i].pid == 0) // child
     506:	0f 84 0b 02 00 00    	je     717 <test_case_3+0x247>
    printf(1, "parent (pid: %d) tranferred %d tickets to child (pid: %d), transfer_tickets() returned %d. \n", 
     50c:	83 ec 08             	sub    $0x8,%esp
     50f:	6a 14                	push   $0x14
     511:	50                   	push   %eax
     512:	e8 14 08 00 00       	call   d2b <transfer_tickets>
     517:	8b 35 e8 18 00 00    	mov    0x18e8,%esi
     51d:	89 c3                	mov    %eax,%ebx
     51f:	e8 bf 07 00 00       	call   ce3 <getpid>
     524:	5a                   	pop    %edx
     525:	59                   	pop    %ecx
     526:	53                   	push   %ebx
     527:	56                   	push   %esi
     528:	6a 14                	push   $0x14
     52a:	50                   	push   %eax
     52b:	68 c0 12 00 00       	push   $0x12c0
     530:	6a 01                	push   $0x1
     532:	e8 b9 08 00 00       	call   df0 <printf>
    printf(1, "parent (pid: %d) now has %d tickets.\n", getpid(), tickets_owned(getpid()));
     537:	83 c4 20             	add    $0x20,%esp
     53a:	e8 a4 07 00 00       	call   ce3 <getpid>
     53f:	83 ec 0c             	sub    $0xc,%esp
     542:	50                   	push   %eax
     543:	e8 db 07 00 00       	call   d23 <tickets_owned>
     548:	89 c3                	mov    %eax,%ebx
     54a:	e8 94 07 00 00       	call   ce3 <getpid>
     54f:	53                   	push   %ebx
     550:	50                   	push   %eax
     551:	68 20 13 00 00       	push   $0x1320
     556:	6a 01                	push   $0x1
     558:	e8 93 08 00 00       	call   df0 <printf>
    printf(1, "parent (pid: %d) tranferred %d tickets to child (pid: %d), transfer_tickets() returned %d. \n", 
     55d:	83 c4 18             	add    $0x18,%esp
     560:	6a fe                	push   $0xfffffffe
     562:	ff 35 e8 18 00 00    	pushl  0x18e8
     568:	e8 be 07 00 00       	call   d2b <transfer_tickets>
     56d:	8b 35 e8 18 00 00    	mov    0x18e8,%esi
     573:	89 c3                	mov    %eax,%ebx
     575:	e8 69 07 00 00       	call   ce3 <getpid>
     57a:	5f                   	pop    %edi
     57b:	5a                   	pop    %edx
     57c:	53                   	push   %ebx
     57d:	56                   	push   %esi
     57e:	6a fe                	push   $0xfffffffe
     580:	50                   	push   %eax
     581:	68 c0 12 00 00       	push   $0x12c0
     586:	6a 01                	push   $0x1
     588:	e8 63 08 00 00       	call   df0 <printf>
    printf(1, "parent (pid: %d) now has %d tickets.\n", getpid(), tickets_owned(getpid()));
     58d:	83 c4 20             	add    $0x20,%esp
     590:	e8 4e 07 00 00       	call   ce3 <getpid>
     595:	83 ec 0c             	sub    $0xc,%esp
     598:	50                   	push   %eax
     599:	e8 85 07 00 00       	call   d23 <tickets_owned>
     59e:	89 c3                	mov    %eax,%ebx
     5a0:	e8 3e 07 00 00       	call   ce3 <getpid>
     5a5:	53                   	push   %ebx
     5a6:	50                   	push   %eax
     5a7:	68 20 13 00 00       	push   $0x1320
     5ac:	6a 01                	push   $0x1
     5ae:	e8 3d 08 00 00       	call   df0 <printf>
    tickets_transferred = tickets_owned(getpid());
     5b3:	83 c4 20             	add    $0x20,%esp
     5b6:	e8 28 07 00 00       	call   ce3 <getpid>
     5bb:	83 ec 0c             	sub    $0xc,%esp
     5be:	50                   	push   %eax
     5bf:	e8 5f 07 00 00       	call   d23 <tickets_owned>
    printf(1, "parent (pid: %d) tranferred %d tickets to child (pid: %d), transfer_tickets() returned %d. \n", 
     5c4:	59                   	pop    %ecx
     5c5:	5e                   	pop    %esi
     5c6:	50                   	push   %eax
    tickets_transferred = tickets_owned(getpid());
     5c7:	89 c3                	mov    %eax,%ebx
    printf(1, "parent (pid: %d) tranferred %d tickets to child (pid: %d), transfer_tickets() returned %d. \n", 
     5c9:	ff 35 e8 18 00 00    	pushl  0x18e8
     5cf:	e8 57 07 00 00       	call   d2b <transfer_tickets>
     5d4:	8b 3d e8 18 00 00    	mov    0x18e8,%edi
     5da:	89 c6                	mov    %eax,%esi
     5dc:	e8 02 07 00 00       	call   ce3 <getpid>
     5e1:	5a                   	pop    %edx
     5e2:	59                   	pop    %ecx
     5e3:	56                   	push   %esi
     5e4:	57                   	push   %edi
     5e5:	53                   	push   %ebx
     5e6:	50                   	push   %eax
     5e7:	68 c0 12 00 00       	push   $0x12c0
     5ec:	6a 01                	push   $0x1
     5ee:	e8 fd 07 00 00       	call   df0 <printf>
    printf(1, "parent (pid: %d) now has %d tickets.\n", getpid(), tickets_owned(getpid()));
     5f3:	83 c4 20             	add    $0x20,%esp
     5f6:	e8 e8 06 00 00       	call   ce3 <getpid>
     5fb:	83 ec 0c             	sub    $0xc,%esp
     5fe:	50                   	push   %eax
     5ff:	e8 1f 07 00 00       	call   d23 <tickets_owned>
     604:	89 c3                	mov    %eax,%ebx
     606:	e8 d8 06 00 00       	call   ce3 <getpid>
     60b:	53                   	push   %ebx
     60c:	50                   	push   %eax
     60d:	68 20 13 00 00       	push   $0x1320
     612:	6a 01                	push   $0x1
     614:	e8 d7 07 00 00       	call   df0 <printf>
    printf(1, "parent (pid: %d) tranferred %d tickets to child (pid: 9999), transfer_tickets() returned %d. \n", 
     619:	83 c4 18             	add    $0x18,%esp
     61c:	6a 14                	push   $0x14
     61e:	68 0f 27 00 00       	push   $0x270f
     623:	e8 03 07 00 00       	call   d2b <transfer_tickets>
     628:	89 c3                	mov    %eax,%ebx
     62a:	e8 b4 06 00 00       	call   ce3 <getpid>
     62f:	89 1c 24             	mov    %ebx,(%esp)
     632:	6a 14                	push   $0x14
     634:	50                   	push   %eax
     635:	68 48 13 00 00       	push   $0x1348
     63a:	6a 01                	push   $0x1
     63c:	e8 af 07 00 00       	call   df0 <printf>
    printf(1, "parent (pid: %d) now has %d tickets.\n", getpid(), tickets_owned(getpid()));
     641:	83 c4 20             	add    $0x20,%esp
     644:	e8 9a 06 00 00       	call   ce3 <getpid>
     649:	83 ec 0c             	sub    $0xc,%esp
     64c:	50                   	push   %eax
     64d:	e8 d1 06 00 00       	call   d23 <tickets_owned>
     652:	89 c3                	mov    %eax,%ebx
     654:	e8 8a 06 00 00       	call   ce3 <getpid>
     659:	53                   	push   %ebx
     65a:	50                   	push   %eax
     65b:	68 20 13 00 00       	push   $0x1320
     660:	6a 01                	push   $0x1
     662:	e8 89 07 00 00       	call   df0 <printf>
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     667:	83 c4 20             	add    $0x20,%esp
     66a:	e8 74 06 00 00       	call   ce3 <getpid>
     66f:	83 ec 0c             	sub    $0xc,%esp
     672:	50                   	push   %eax
     673:	e8 ab 06 00 00       	call   d23 <tickets_owned>
     678:	89 c3                	mov    %eax,%ebx
     67a:	e8 64 06 00 00       	call   ce3 <getpid>
     67f:	53                   	push   %ebx
     680:	50                   	push   %eax
     681:	68 88 11 00 00       	push   $0x1188
     686:	6a 01                	push   $0x1
     688:	e8 63 07 00 00       	call   df0 <printf>
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     68d:	83 c4 14             	add    $0x14,%esp
     690:	ff 35 e8 18 00 00    	pushl  0x18e8
     696:	e8 88 06 00 00       	call   d23 <tickets_owned>
     69b:	50                   	push   %eax
     69c:	ff 35 e8 18 00 00    	pushl  0x18e8
     6a2:	68 ac 11 00 00       	push   $0x11ac
     6a7:	6a 01                	push   $0x1
     6a9:	e8 42 07 00 00       	call   df0 <printf>
     6ae:	83 c4 20             	add    $0x20,%esp
    unsigned int tmp = 0;
     6b1:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     6b3:	31 c0                	xor    %eax,%eax
     6b5:	8d 76 00             	lea    0x0(%esi),%esi
        tmp += cnt;
     6b8:	01 c2                	add    %eax,%edx
        cnt ++;
     6ba:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     6bd:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     6c2:	75 f4                	jne    6b8 <test_case_3+0x1e8>
    avoid_optm = tmp;
     6c4:	89 15 e4 18 00 00    	mov    %edx,0x18e4
       if (wait() < 0)
     6ca:	e8 9c 05 00 00       	call   c6b <wait>
     6cf:	85 c0                	test   %eax,%eax
     6d1:	78 1a                	js     6ed <test_case_3+0x21d>
    printf(1, "\n\n");     
     6d3:	83 ec 08             	sub    $0x8,%esp
     6d6:	68 85 11 00 00       	push   $0x1185
     6db:	6a 01                	push   $0x1
     6dd:	e8 0e 07 00 00       	call   df0 <printf>
}
     6e2:	83 c4 10             	add    $0x10,%esp
     6e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6e8:	5b                   	pop    %ebx
     6e9:	5e                   	pop    %esi
     6ea:	5f                   	pop    %edi
     6eb:	5d                   	pop    %ebp
     6ec:	c3                   	ret    
            printf(1, "\nwait() on child-%d failed!\n", i);
     6ed:	83 ec 04             	sub    $0x4,%esp
     6f0:	6a 00                	push   $0x0
     6f2:	68 68 11 00 00       	push   $0x1168
     6f7:	6a 01                	push   $0x1
     6f9:	e8 f2 06 00 00       	call   df0 <printf>
     6fe:	83 c4 10             	add    $0x10,%esp
     701:	eb d0                	jmp    6d3 <test_case_3+0x203>
            printf(1, "fork() failed!\n");
     703:	83 ec 08             	sub    $0x8,%esp
     706:	68 58 11 00 00       	push   $0x1158
     70b:	6a 01                	push   $0x1
     70d:	e8 de 06 00 00       	call   df0 <printf>
            exit();
     712:	e8 4c 05 00 00       	call   c63 <exit>
    unsigned int tmp = 0;
     717:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     719:	31 c0                	xor    %eax,%eax
     71b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     71f:	90                   	nop
        tmp += cnt;
     720:	01 c2                	add    %eax,%edx
        cnt ++;
     722:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     725:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     72a:	75 f4                	jne    720 <test_case_3+0x250>
    avoid_optm = tmp;
     72c:	89 15 e4 18 00 00    	mov    %edx,0x18e4
            exit();
     732:	e8 2c 05 00 00       	call   c63 <exit>
     737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     73e:	66 90                	xchg   %ax,%ax

00000740 <test_case_4>:
{
     740:	55                   	push   %ebp
     741:	89 e5                	mov    %esp,%ebp
     743:	56                   	push   %esi
     744:	53                   	push   %ebx
    printf(1, "===== Test case 4: stride scheduler, %d child, with ticket trasfer at the beginning ... =====\n", child_cnt);
     745:	83 ec 04             	sub    $0x4,%esp
     748:	6a 01                	push   $0x1
     74a:	68 a8 13 00 00       	push   $0x13a8
     74f:	6a 01                	push   $0x1
     751:	e8 9a 06 00 00       	call   df0 <printf>
    set_sched(scheduler);
     756:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     75d:	e8 b9 05 00 00       	call   d1b <set_sched>
        child[i].pid = fork();
     762:	e8 f4 04 00 00       	call   c5b <fork>
        if (child[i].pid < 0)
     767:	83 c4 10             	add    $0x10,%esp
        child[i].pid = fork();
     76a:	a3 e8 18 00 00       	mov    %eax,0x18e8
        if (child[i].pid < 0)
     76f:	85 c0                	test   %eax,%eax
     771:	0f 88 fc 00 00 00    	js     873 <test_case_4+0x133>
        else if (child[i].pid == 0) // child
     777:	0f 84 0a 01 00 00    	je     887 <test_case_4+0x147>
    tickets_transferred = tickets_owned(getpid())/2;
     77d:	e8 61 05 00 00       	call   ce3 <getpid>
     782:	83 ec 0c             	sub    $0xc,%esp
     785:	50                   	push   %eax
     786:	e8 98 05 00 00       	call   d23 <tickets_owned>
    transfer_tickets(child[0].pid, tickets_transferred);
     78b:	59                   	pop    %ecx
     78c:	5e                   	pop    %esi
    tickets_transferred = tickets_owned(getpid())/2;
     78d:	89 c2                	mov    %eax,%edx
     78f:	c1 ea 1f             	shr    $0x1f,%edx
     792:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
     795:	d1 fb                	sar    %ebx
    transfer_tickets(child[0].pid, tickets_transferred);
     797:	53                   	push   %ebx
     798:	ff 35 e8 18 00 00    	pushl  0x18e8
     79e:	e8 88 05 00 00       	call   d2b <transfer_tickets>
    printf(1, "parent (pid: %d) transferred %d tickets to child (pid: %d)\n", getpid(), tickets_transferred, child[0].pid);
     7a3:	8b 35 e8 18 00 00    	mov    0x18e8,%esi
     7a9:	e8 35 05 00 00       	call   ce3 <getpid>
     7ae:	89 34 24             	mov    %esi,(%esp)
     7b1:	53                   	push   %ebx
     7b2:	50                   	push   %eax
     7b3:	68 08 14 00 00       	push   $0x1408
     7b8:	6a 01                	push   $0x1
     7ba:	e8 31 06 00 00       	call   df0 <printf>
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     7bf:	83 c4 20             	add    $0x20,%esp
     7c2:	e8 1c 05 00 00       	call   ce3 <getpid>
     7c7:	83 ec 0c             	sub    $0xc,%esp
     7ca:	50                   	push   %eax
     7cb:	e8 53 05 00 00       	call   d23 <tickets_owned>
     7d0:	89 c3                	mov    %eax,%ebx
     7d2:	e8 0c 05 00 00       	call   ce3 <getpid>
     7d7:	53                   	push   %ebx
     7d8:	50                   	push   %eax
     7d9:	68 88 11 00 00       	push   $0x1188
     7de:	6a 01                	push   $0x1
     7e0:	e8 0b 06 00 00       	call   df0 <printf>
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     7e5:	83 c4 14             	add    $0x14,%esp
     7e8:	ff 35 e8 18 00 00    	pushl  0x18e8
     7ee:	e8 30 05 00 00       	call   d23 <tickets_owned>
     7f3:	50                   	push   %eax
     7f4:	ff 35 e8 18 00 00    	pushl  0x18e8
     7fa:	68 ac 11 00 00       	push   $0x11ac
     7ff:	6a 01                	push   $0x1
     801:	e8 ea 05 00 00       	call   df0 <printf>
    enable_sched_trace(1);
     806:	83 c4 14             	add    $0x14,%esp
     809:	6a 01                	push   $0x1
     80b:	e8 fb 04 00 00       	call   d0b <enable_sched_trace>
     810:	83 c4 10             	add    $0x10,%esp
    unsigned int tmp = 0;
     813:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     815:	31 c0                	xor    %eax,%eax
     817:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     81e:	66 90                	xchg   %ax,%ax
        tmp += cnt;
     820:	01 c2                	add    %eax,%edx
        cnt ++;
     822:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     825:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     82a:	75 f4                	jne    820 <test_case_4+0xe0>
    avoid_optm = tmp;
     82c:	89 15 e4 18 00 00    	mov    %edx,0x18e4
       if (wait() < 0)
     832:	e8 34 04 00 00       	call   c6b <wait>
     837:	85 c0                	test   %eax,%eax
     839:	78 22                	js     85d <test_case_4+0x11d>
    enable_sched_trace(0);
     83b:	83 ec 0c             	sub    $0xc,%esp
     83e:	6a 00                	push   $0x0
     840:	e8 c6 04 00 00       	call   d0b <enable_sched_trace>
    printf(1, "\n\n");
     845:	58                   	pop    %eax
     846:	5a                   	pop    %edx
     847:	68 85 11 00 00       	push   $0x1185
     84c:	6a 01                	push   $0x1
     84e:	e8 9d 05 00 00       	call   df0 <printf>
}
     853:	83 c4 10             	add    $0x10,%esp
     856:	8d 65 f8             	lea    -0x8(%ebp),%esp
     859:	5b                   	pop    %ebx
     85a:	5e                   	pop    %esi
     85b:	5d                   	pop    %ebp
     85c:	c3                   	ret    
            printf(1, "\nwait() on child-%d failed!\n", i);
     85d:	83 ec 04             	sub    $0x4,%esp
     860:	6a 00                	push   $0x0
     862:	68 68 11 00 00       	push   $0x1168
     867:	6a 01                	push   $0x1
     869:	e8 82 05 00 00       	call   df0 <printf>
     86e:	83 c4 10             	add    $0x10,%esp
     871:	eb c8                	jmp    83b <test_case_4+0xfb>
            printf(1, "fork() failed!\n");
     873:	83 ec 08             	sub    $0x8,%esp
     876:	68 58 11 00 00       	push   $0x1158
     87b:	6a 01                	push   $0x1
     87d:	e8 6e 05 00 00       	call   df0 <printf>
            exit();
     882:	e8 dc 03 00 00       	call   c63 <exit>
    unsigned int tmp = 0;
     887:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     889:	31 c0                	xor    %eax,%eax
     88b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     88f:	90                   	nop
        tmp += cnt;
     890:	01 c2                	add    %eax,%edx
        cnt ++;
     892:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     895:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     89a:	75 f4                	jne    890 <test_case_4+0x150>
    avoid_optm = tmp;
     89c:	89 15 e4 18 00 00    	mov    %edx,0x18e4
            exit();
     8a2:	e8 bc 03 00 00       	call   c63 <exit>
     8a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8ae:	66 90                	xchg   %ax,%ax

000008b0 <test_case_5>:
{
     8b0:	55                   	push   %ebp
     8b1:	89 e5                	mov    %esp,%ebp
     8b3:	56                   	push   %esi
     8b4:	53                   	push   %ebx
    printf(1, "===== Test case 5: stride scheduler, %d child, with ticket trasfer at the beginning ... =====\n", child_cnt);
     8b5:	83 ec 04             	sub    $0x4,%esp
     8b8:	6a 01                	push   $0x1
     8ba:	68 44 14 00 00       	push   $0x1444
     8bf:	6a 01                	push   $0x1
     8c1:	e8 2a 05 00 00       	call   df0 <printf>
    set_sched(scheduler);
     8c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     8cd:	e8 49 04 00 00       	call   d1b <set_sched>
        child[i].pid = fork();
     8d2:	e8 84 03 00 00       	call   c5b <fork>
        if (child[i].pid < 0)
     8d7:	83 c4 10             	add    $0x10,%esp
        child[i].pid = fork();
     8da:	a3 e8 18 00 00       	mov    %eax,0x18e8
        if (child[i].pid < 0)
     8df:	85 c0                	test   %eax,%eax
     8e1:	0f 88 ec 00 00 00    	js     9d3 <test_case_5+0x123>
        else if (child[i].pid == 0) // child
     8e7:	0f 84 fa 00 00 00    	je     9e7 <test_case_5+0x137>
    tickets_transferred = tickets_owned(getpid()) - 1;
     8ed:	e8 f1 03 00 00       	call   ce3 <getpid>
     8f2:	83 ec 0c             	sub    $0xc,%esp
     8f5:	50                   	push   %eax
     8f6:	e8 28 04 00 00       	call   d23 <tickets_owned>
    transfer_tickets(child[0].pid, tickets_transferred);
     8fb:	59                   	pop    %ecx
     8fc:	5e                   	pop    %esi
    tickets_transferred = tickets_owned(getpid()) - 1;
     8fd:	8d 58 ff             	lea    -0x1(%eax),%ebx
    transfer_tickets(child[0].pid, tickets_transferred);
     900:	53                   	push   %ebx
     901:	ff 35 e8 18 00 00    	pushl  0x18e8
     907:	e8 1f 04 00 00       	call   d2b <transfer_tickets>
    printf(1, "parent (pid: %d) transferred %d tickets to child (pid: %d)\n", getpid(), tickets_transferred, child[0].pid);
     90c:	8b 35 e8 18 00 00    	mov    0x18e8,%esi
     912:	e8 cc 03 00 00       	call   ce3 <getpid>
     917:	89 34 24             	mov    %esi,(%esp)
     91a:	53                   	push   %ebx
     91b:	50                   	push   %eax
     91c:	68 08 14 00 00       	push   $0x1408
     921:	6a 01                	push   $0x1
     923:	e8 c8 04 00 00       	call   df0 <printf>
    printf(1, "parent (pid %d) has %d tickets.\n", getpid(), tickets_owned(getpid()));
     928:	83 c4 20             	add    $0x20,%esp
     92b:	e8 b3 03 00 00       	call   ce3 <getpid>
     930:	83 ec 0c             	sub    $0xc,%esp
     933:	50                   	push   %eax
     934:	e8 ea 03 00 00       	call   d23 <tickets_owned>
     939:	89 c3                	mov    %eax,%ebx
     93b:	e8 a3 03 00 00       	call   ce3 <getpid>
     940:	53                   	push   %ebx
     941:	50                   	push   %eax
     942:	68 88 11 00 00       	push   $0x1188
     947:	6a 01                	push   $0x1
     949:	e8 a2 04 00 00       	call   df0 <printf>
        printf(1, "child (pid %d) has %d tickets.\n", child[i].pid, tickets_owned(child[i].pid));     
     94e:	83 c4 14             	add    $0x14,%esp
     951:	ff 35 e8 18 00 00    	pushl  0x18e8
     957:	e8 c7 03 00 00       	call   d23 <tickets_owned>
     95c:	50                   	push   %eax
     95d:	ff 35 e8 18 00 00    	pushl  0x18e8
     963:	68 ac 11 00 00       	push   $0x11ac
     968:	6a 01                	push   $0x1
     96a:	e8 81 04 00 00       	call   df0 <printf>
    enable_sched_trace(1);
     96f:	83 c4 14             	add    $0x14,%esp
     972:	6a 01                	push   $0x1
     974:	e8 92 03 00 00       	call   d0b <enable_sched_trace>
     979:	83 c4 10             	add    $0x10,%esp
    unsigned int tmp = 0;
     97c:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     97e:	31 c0                	xor    %eax,%eax
        tmp += cnt;
     980:	01 c2                	add    %eax,%edx
        cnt ++;
     982:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     985:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     98a:	75 f4                	jne    980 <test_case_5+0xd0>
    avoid_optm = tmp;
     98c:	89 15 e4 18 00 00    	mov    %edx,0x18e4
       if (wait() < 0)
     992:	e8 d4 02 00 00       	call   c6b <wait>
     997:	85 c0                	test   %eax,%eax
     999:	78 22                	js     9bd <test_case_5+0x10d>
    enable_sched_trace(0);
     99b:	83 ec 0c             	sub    $0xc,%esp
     99e:	6a 00                	push   $0x0
     9a0:	e8 66 03 00 00       	call   d0b <enable_sched_trace>
    printf(1, "\n\n");
     9a5:	58                   	pop    %eax
     9a6:	5a                   	pop    %edx
     9a7:	68 85 11 00 00       	push   $0x1185
     9ac:	6a 01                	push   $0x1
     9ae:	e8 3d 04 00 00       	call   df0 <printf>
}
     9b3:	83 c4 10             	add    $0x10,%esp
     9b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     9b9:	5b                   	pop    %ebx
     9ba:	5e                   	pop    %esi
     9bb:	5d                   	pop    %ebp
     9bc:	c3                   	ret    
            printf(1, "\nwait() on child-%d failed!\n", i);
     9bd:	83 ec 04             	sub    $0x4,%esp
     9c0:	6a 00                	push   $0x0
     9c2:	68 68 11 00 00       	push   $0x1168
     9c7:	6a 01                	push   $0x1
     9c9:	e8 22 04 00 00       	call   df0 <printf>
     9ce:	83 c4 10             	add    $0x10,%esp
     9d1:	eb c8                	jmp    99b <test_case_5+0xeb>
            printf(1, "fork() failed!\n");
     9d3:	83 ec 08             	sub    $0x8,%esp
     9d6:	68 58 11 00 00       	push   $0x1158
     9db:	6a 01                	push   $0x1
     9dd:	e8 0e 04 00 00       	call   df0 <printf>
            exit();
     9e2:	e8 7c 02 00 00       	call   c63 <exit>
    unsigned int tmp = 0;
     9e7:	31 d2                	xor    %edx,%edx
    unsigned int cnt = 0;
     9e9:	31 c0                	xor    %eax,%eax
     9eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9ef:	90                   	nop
        tmp += cnt;
     9f0:	01 c2                	add    %eax,%edx
        cnt ++;
     9f2:	83 c0 01             	add    $0x1,%eax
    while(cnt < LOOP_CNT)
     9f5:	3d 00 00 00 10       	cmp    $0x10000000,%eax
     9fa:	75 f4                	jne    9f0 <test_case_5+0x140>
    avoid_optm = tmp;
     9fc:	89 15 e4 18 00 00    	mov    %edx,0x18e4
            exit();
     a02:	e8 5c 02 00 00       	call   c63 <exit>
     a07:	66 90                	xchg   %ax,%ax
     a09:	66 90                	xchg   %ax,%ax
     a0b:	66 90                	xchg   %ax,%ax
     a0d:	66 90                	xchg   %ax,%ax
     a0f:	90                   	nop

00000a10 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     a10:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     a11:	31 c0                	xor    %eax,%eax
{
     a13:	89 e5                	mov    %esp,%ebp
     a15:	53                   	push   %ebx
     a16:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a19:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     a20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     a24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     a27:	83 c0 01             	add    $0x1,%eax
     a2a:	84 d2                	test   %dl,%dl
     a2c:	75 f2                	jne    a20 <strcpy+0x10>
    ;
  return os;
}
     a2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a31:	89 c8                	mov    %ecx,%eax
     a33:	c9                   	leave  
     a34:	c3                   	ret    
     a35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a40 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     a40:	55                   	push   %ebp
     a41:	89 e5                	mov    %esp,%ebp
     a43:	53                   	push   %ebx
     a44:	8b 4d 08             	mov    0x8(%ebp),%ecx
     a47:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
     a4a:	0f b6 01             	movzbl (%ecx),%eax
     a4d:	0f b6 1a             	movzbl (%edx),%ebx
     a50:	84 c0                	test   %al,%al
     a52:	75 1d                	jne    a71 <strcmp+0x31>
     a54:	eb 2a                	jmp    a80 <strcmp+0x40>
     a56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a5d:	8d 76 00             	lea    0x0(%esi),%esi
     a60:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
     a64:	83 c1 01             	add    $0x1,%ecx
     a67:	83 c2 01             	add    $0x1,%edx
  return (uchar)*p - (uchar)*q;
     a6a:	0f b6 1a             	movzbl (%edx),%ebx
  while(*p && *p == *q)
     a6d:	84 c0                	test   %al,%al
     a6f:	74 0f                	je     a80 <strcmp+0x40>
     a71:	38 d8                	cmp    %bl,%al
     a73:	74 eb                	je     a60 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     a75:	29 d8                	sub    %ebx,%eax
}
     a77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a7a:	c9                   	leave  
     a7b:	c3                   	ret    
     a7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a80:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     a82:	29 d8                	sub    %ebx,%eax
}
     a84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a87:	c9                   	leave  
     a88:	c3                   	ret    
     a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000a90 <strlen>:

uint
strlen(char *s)
{
     a90:	55                   	push   %ebp
     a91:	89 e5                	mov    %esp,%ebp
     a93:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     a96:	80 3a 00             	cmpb   $0x0,(%edx)
     a99:	74 15                	je     ab0 <strlen+0x20>
     a9b:	31 c0                	xor    %eax,%eax
     a9d:	8d 76 00             	lea    0x0(%esi),%esi
     aa0:	83 c0 01             	add    $0x1,%eax
     aa3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     aa7:	89 c1                	mov    %eax,%ecx
     aa9:	75 f5                	jne    aa0 <strlen+0x10>
    ;
  return n;
}
     aab:	89 c8                	mov    %ecx,%eax
     aad:	5d                   	pop    %ebp
     aae:	c3                   	ret    
     aaf:	90                   	nop
  for(n = 0; s[n]; n++)
     ab0:	31 c9                	xor    %ecx,%ecx
}
     ab2:	5d                   	pop    %ebp
     ab3:	89 c8                	mov    %ecx,%eax
     ab5:	c3                   	ret    
     ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     abd:	8d 76 00             	lea    0x0(%esi),%esi

00000ac0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	57                   	push   %edi
     ac4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     ac7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     aca:	8b 45 0c             	mov    0xc(%ebp),%eax
     acd:	89 d7                	mov    %edx,%edi
     acf:	fc                   	cld    
     ad0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ad2:	8b 7d fc             	mov    -0x4(%ebp),%edi
     ad5:	89 d0                	mov    %edx,%eax
     ad7:	c9                   	leave  
     ad8:	c3                   	ret    
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ae0 <strchr>:

char*
strchr(const char *s, char c)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	8b 45 08             	mov    0x8(%ebp),%eax
     ae6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     aea:	0f b6 10             	movzbl (%eax),%edx
     aed:	84 d2                	test   %dl,%dl
     aef:	75 12                	jne    b03 <strchr+0x23>
     af1:	eb 1d                	jmp    b10 <strchr+0x30>
     af3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     af7:	90                   	nop
     af8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     afc:	83 c0 01             	add    $0x1,%eax
     aff:	84 d2                	test   %dl,%dl
     b01:	74 0d                	je     b10 <strchr+0x30>
    if(*s == c)
     b03:	38 d1                	cmp    %dl,%cl
     b05:	75 f1                	jne    af8 <strchr+0x18>
      return (char*)s;
  return 0;
}
     b07:	5d                   	pop    %ebp
     b08:	c3                   	ret    
     b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     b10:	31 c0                	xor    %eax,%eax
}
     b12:	5d                   	pop    %ebp
     b13:	c3                   	ret    
     b14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b1f:	90                   	nop

00000b20 <gets>:

char*
gets(char *buf, int max)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	57                   	push   %edi
     b24:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     b25:	31 f6                	xor    %esi,%esi
{
     b27:	53                   	push   %ebx
     b28:	89 f3                	mov    %esi,%ebx
     b2a:	83 ec 1c             	sub    $0x1c,%esp
     b2d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     b30:	eb 2f                	jmp    b61 <gets+0x41>
     b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     b38:	83 ec 04             	sub    $0x4,%esp
     b3b:	8d 45 e7             	lea    -0x19(%ebp),%eax
     b3e:	6a 01                	push   $0x1
     b40:	50                   	push   %eax
     b41:	6a 00                	push   $0x0
     b43:	e8 33 01 00 00       	call   c7b <read>
    if(cc < 1)
     b48:	83 c4 10             	add    $0x10,%esp
     b4b:	85 c0                	test   %eax,%eax
     b4d:	7e 1c                	jle    b6b <gets+0x4b>
      break;
    buf[i++] = c;
     b4f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    if(c == '\n' || c == '\r')
     b53:	83 c7 01             	add    $0x1,%edi
    buf[i++] = c;
     b56:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     b59:	3c 0a                	cmp    $0xa,%al
     b5b:	74 23                	je     b80 <gets+0x60>
     b5d:	3c 0d                	cmp    $0xd,%al
     b5f:	74 1f                	je     b80 <gets+0x60>
  for(i=0; i+1 < max; ){
     b61:	83 c3 01             	add    $0x1,%ebx
    buf[i++] = c;
     b64:	89 fe                	mov    %edi,%esi
  for(i=0; i+1 < max; ){
     b66:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     b69:	7c cd                	jl     b38 <gets+0x18>
     b6b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     b70:	c6 03 00             	movb   $0x0,(%ebx)
}
     b73:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b76:	5b                   	pop    %ebx
     b77:	5e                   	pop    %esi
     b78:	5f                   	pop    %edi
     b79:	5d                   	pop    %ebp
     b7a:	c3                   	ret    
     b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     b7f:	90                   	nop
  buf[i] = '\0';
     b80:	8b 75 08             	mov    0x8(%ebp),%esi
}
     b83:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     b86:	01 de                	add    %ebx,%esi
     b88:	89 f3                	mov    %esi,%ebx
     b8a:	c6 03 00             	movb   $0x0,(%ebx)
}
     b8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b90:	5b                   	pop    %ebx
     b91:	5e                   	pop    %esi
     b92:	5f                   	pop    %edi
     b93:	5d                   	pop    %ebp
     b94:	c3                   	ret    
     b95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ba0 <stat>:

int
stat(char *n, struct stat *st)
{
     ba0:	55                   	push   %ebp
     ba1:	89 e5                	mov    %esp,%ebp
     ba3:	56                   	push   %esi
     ba4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     ba5:	83 ec 08             	sub    $0x8,%esp
     ba8:	6a 00                	push   $0x0
     baa:	ff 75 08             	pushl  0x8(%ebp)
     bad:	e8 f1 00 00 00       	call   ca3 <open>
  if(fd < 0)
     bb2:	83 c4 10             	add    $0x10,%esp
     bb5:	85 c0                	test   %eax,%eax
     bb7:	78 27                	js     be0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     bb9:	83 ec 08             	sub    $0x8,%esp
     bbc:	ff 75 0c             	pushl  0xc(%ebp)
     bbf:	89 c3                	mov    %eax,%ebx
     bc1:	50                   	push   %eax
     bc2:	e8 f4 00 00 00       	call   cbb <fstat>
  close(fd);
     bc7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     bca:	89 c6                	mov    %eax,%esi
  close(fd);
     bcc:	e8 ba 00 00 00       	call   c8b <close>
  return r;
     bd1:	83 c4 10             	add    $0x10,%esp
}
     bd4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     bd7:	89 f0                	mov    %esi,%eax
     bd9:	5b                   	pop    %ebx
     bda:	5e                   	pop    %esi
     bdb:	5d                   	pop    %ebp
     bdc:	c3                   	ret    
     bdd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     be0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     be5:	eb ed                	jmp    bd4 <stat+0x34>
     be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bee:	66 90                	xchg   %ax,%ax

00000bf0 <atoi>:

int
atoi(const char *s)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	53                   	push   %ebx
     bf4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     bf7:	0f be 02             	movsbl (%edx),%eax
     bfa:	8d 48 d0             	lea    -0x30(%eax),%ecx
     bfd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
     c00:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
     c05:	77 1e                	ja     c25 <atoi+0x35>
     c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c0e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     c10:	83 c2 01             	add    $0x1,%edx
     c13:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
     c16:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
     c1a:	0f be 02             	movsbl (%edx),%eax
     c1d:	8d 58 d0             	lea    -0x30(%eax),%ebx
     c20:	80 fb 09             	cmp    $0x9,%bl
     c23:	76 eb                	jbe    c10 <atoi+0x20>
  return n;
}
     c25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     c28:	89 c8                	mov    %ecx,%eax
     c2a:	c9                   	leave  
     c2b:	c3                   	ret    
     c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c30 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	57                   	push   %edi
     c34:	8b 45 10             	mov    0x10(%ebp),%eax
     c37:	8b 55 08             	mov    0x8(%ebp),%edx
     c3a:	56                   	push   %esi
     c3b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     c3e:	85 c0                	test   %eax,%eax
     c40:	7e 13                	jle    c55 <memmove+0x25>
     c42:	01 d0                	add    %edx,%eax
  dst = vdst;
     c44:	89 d7                	mov    %edx,%edi
     c46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c4d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
     c50:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
     c51:	39 f8                	cmp    %edi,%eax
     c53:	75 fb                	jne    c50 <memmove+0x20>
  return vdst;
}
     c55:	5e                   	pop    %esi
     c56:	89 d0                	mov    %edx,%eax
     c58:	5f                   	pop    %edi
     c59:	5d                   	pop    %ebp
     c5a:	c3                   	ret    

00000c5b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     c5b:	b8 01 00 00 00       	mov    $0x1,%eax
     c60:	cd 40                	int    $0x40
     c62:	c3                   	ret    

00000c63 <exit>:
SYSCALL(exit)
     c63:	b8 02 00 00 00       	mov    $0x2,%eax
     c68:	cd 40                	int    $0x40
     c6a:	c3                   	ret    

00000c6b <wait>:
SYSCALL(wait)
     c6b:	b8 03 00 00 00       	mov    $0x3,%eax
     c70:	cd 40                	int    $0x40
     c72:	c3                   	ret    

00000c73 <pipe>:
SYSCALL(pipe)
     c73:	b8 04 00 00 00       	mov    $0x4,%eax
     c78:	cd 40                	int    $0x40
     c7a:	c3                   	ret    

00000c7b <read>:
SYSCALL(read)
     c7b:	b8 05 00 00 00       	mov    $0x5,%eax
     c80:	cd 40                	int    $0x40
     c82:	c3                   	ret    

00000c83 <write>:
SYSCALL(write)
     c83:	b8 10 00 00 00       	mov    $0x10,%eax
     c88:	cd 40                	int    $0x40
     c8a:	c3                   	ret    

00000c8b <close>:
SYSCALL(close)
     c8b:	b8 15 00 00 00       	mov    $0x15,%eax
     c90:	cd 40                	int    $0x40
     c92:	c3                   	ret    

00000c93 <kill>:
SYSCALL(kill)
     c93:	b8 06 00 00 00       	mov    $0x6,%eax
     c98:	cd 40                	int    $0x40
     c9a:	c3                   	ret    

00000c9b <exec>:
SYSCALL(exec)
     c9b:	b8 07 00 00 00       	mov    $0x7,%eax
     ca0:	cd 40                	int    $0x40
     ca2:	c3                   	ret    

00000ca3 <open>:
SYSCALL(open)
     ca3:	b8 0f 00 00 00       	mov    $0xf,%eax
     ca8:	cd 40                	int    $0x40
     caa:	c3                   	ret    

00000cab <mknod>:
SYSCALL(mknod)
     cab:	b8 11 00 00 00       	mov    $0x11,%eax
     cb0:	cd 40                	int    $0x40
     cb2:	c3                   	ret    

00000cb3 <unlink>:
SYSCALL(unlink)
     cb3:	b8 12 00 00 00       	mov    $0x12,%eax
     cb8:	cd 40                	int    $0x40
     cba:	c3                   	ret    

00000cbb <fstat>:
SYSCALL(fstat)
     cbb:	b8 08 00 00 00       	mov    $0x8,%eax
     cc0:	cd 40                	int    $0x40
     cc2:	c3                   	ret    

00000cc3 <link>:
SYSCALL(link)
     cc3:	b8 13 00 00 00       	mov    $0x13,%eax
     cc8:	cd 40                	int    $0x40
     cca:	c3                   	ret    

00000ccb <mkdir>:
SYSCALL(mkdir)
     ccb:	b8 14 00 00 00       	mov    $0x14,%eax
     cd0:	cd 40                	int    $0x40
     cd2:	c3                   	ret    

00000cd3 <chdir>:
SYSCALL(chdir)
     cd3:	b8 09 00 00 00       	mov    $0x9,%eax
     cd8:	cd 40                	int    $0x40
     cda:	c3                   	ret    

00000cdb <dup>:
SYSCALL(dup)
     cdb:	b8 0a 00 00 00       	mov    $0xa,%eax
     ce0:	cd 40                	int    $0x40
     ce2:	c3                   	ret    

00000ce3 <getpid>:
SYSCALL(getpid)
     ce3:	b8 0b 00 00 00       	mov    $0xb,%eax
     ce8:	cd 40                	int    $0x40
     cea:	c3                   	ret    

00000ceb <sbrk>:
SYSCALL(sbrk)
     ceb:	b8 0c 00 00 00       	mov    $0xc,%eax
     cf0:	cd 40                	int    $0x40
     cf2:	c3                   	ret    

00000cf3 <sleep>:
SYSCALL(sleep)
     cf3:	b8 0d 00 00 00       	mov    $0xd,%eax
     cf8:	cd 40                	int    $0x40
     cfa:	c3                   	ret    

00000cfb <uptime>:
SYSCALL(uptime)
     cfb:	b8 0e 00 00 00       	mov    $0xe,%eax
     d00:	cd 40                	int    $0x40
     d02:	c3                   	ret    

00000d03 <shutdown>:
SYSCALL(shutdown)
     d03:	b8 16 00 00 00       	mov    $0x16,%eax
     d08:	cd 40                	int    $0x40
     d0a:	c3                   	ret    

00000d0b <enable_sched_trace>:
SYSCALL(enable_sched_trace)
     d0b:	b8 17 00 00 00       	mov    $0x17,%eax
     d10:	cd 40                	int    $0x40
     d12:	c3                   	ret    

00000d13 <fork_winner>:
SYSCALL(fork_winner)
     d13:	b8 18 00 00 00       	mov    $0x18,%eax
     d18:	cd 40                	int    $0x40
     d1a:	c3                   	ret    

00000d1b <set_sched>:
SYSCALL(set_sched)
     d1b:	b8 19 00 00 00       	mov    $0x19,%eax
     d20:	cd 40                	int    $0x40
     d22:	c3                   	ret    

00000d23 <tickets_owned>:
SYSCALL(tickets_owned)
     d23:	b8 1a 00 00 00       	mov    $0x1a,%eax
     d28:	cd 40                	int    $0x40
     d2a:	c3                   	ret    

00000d2b <transfer_tickets>:
     d2b:	b8 1b 00 00 00       	mov    $0x1b,%eax
     d30:	cd 40                	int    $0x40
     d32:	c3                   	ret    
     d33:	66 90                	xchg   %ax,%ax
     d35:	66 90                	xchg   %ax,%ax
     d37:	66 90                	xchg   %ax,%ax
     d39:	66 90                	xchg   %ax,%ax
     d3b:	66 90                	xchg   %ax,%ax
     d3d:	66 90                	xchg   %ax,%ax
     d3f:	90                   	nop

00000d40 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d40:	55                   	push   %ebp
     d41:	89 e5                	mov    %esp,%ebp
     d43:	57                   	push   %edi
     d44:	56                   	push   %esi
     d45:	53                   	push   %ebx
     d46:	83 ec 3c             	sub    $0x3c,%esp
     d49:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     d4c:	89 d1                	mov    %edx,%ecx
{
     d4e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
     d51:	85 d2                	test   %edx,%edx
     d53:	0f 89 7f 00 00 00    	jns    dd8 <printint+0x98>
     d59:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     d5d:	74 79                	je     dd8 <printint+0x98>
    neg = 1;
     d5f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
     d66:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
     d68:	31 db                	xor    %ebx,%ebx
     d6a:	8d 75 d7             	lea    -0x29(%ebp),%esi
     d6d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
     d70:	89 c8                	mov    %ecx,%eax
     d72:	31 d2                	xor    %edx,%edx
     d74:	89 cf                	mov    %ecx,%edi
     d76:	f7 75 c4             	divl   -0x3c(%ebp)
     d79:	0f b6 92 ac 14 00 00 	movzbl 0x14ac(%edx),%edx
     d80:	89 45 c0             	mov    %eax,-0x40(%ebp)
     d83:	89 d8                	mov    %ebx,%eax
     d85:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
     d88:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
     d8b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
     d8e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
     d91:	76 dd                	jbe    d70 <printint+0x30>
  if(neg)
     d93:	8b 4d bc             	mov    -0x44(%ebp),%ecx
     d96:	85 c9                	test   %ecx,%ecx
     d98:	74 0c                	je     da6 <printint+0x66>
    buf[i++] = '-';
     d9a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
     d9f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
     da1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
     da6:	8b 7d b8             	mov    -0x48(%ebp),%edi
     da9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
     dad:	eb 07                	jmp    db6 <printint+0x76>
     daf:	90                   	nop
    putc(fd, buf[i]);
     db0:	0f b6 13             	movzbl (%ebx),%edx
     db3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
     db6:	83 ec 04             	sub    $0x4,%esp
     db9:	88 55 d7             	mov    %dl,-0x29(%ebp)
     dbc:	6a 01                	push   $0x1
     dbe:	56                   	push   %esi
     dbf:	57                   	push   %edi
     dc0:	e8 be fe ff ff       	call   c83 <write>
  while(--i >= 0)
     dc5:	83 c4 10             	add    $0x10,%esp
     dc8:	39 de                	cmp    %ebx,%esi
     dca:	75 e4                	jne    db0 <printint+0x70>
}
     dcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     dcf:	5b                   	pop    %ebx
     dd0:	5e                   	pop    %esi
     dd1:	5f                   	pop    %edi
     dd2:	5d                   	pop    %ebp
     dd3:	c3                   	ret    
     dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     dd8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
     ddf:	eb 87                	jmp    d68 <printint+0x28>
     de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     def:	90                   	nop

00000df0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	57                   	push   %edi
     df4:	56                   	push   %esi
     df5:	53                   	push   %ebx
     df6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     df9:	8b 75 0c             	mov    0xc(%ebp),%esi
     dfc:	0f b6 1e             	movzbl (%esi),%ebx
     dff:	84 db                	test   %bl,%bl
     e01:	0f 84 b8 00 00 00    	je     ebf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
     e07:	8d 45 10             	lea    0x10(%ebp),%eax
     e0a:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
     e0d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
     e10:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
     e12:	89 45 d0             	mov    %eax,-0x30(%ebp)
     e15:	eb 37                	jmp    e4e <printf+0x5e>
     e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     e1e:	66 90                	xchg   %ax,%ax
     e20:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     e23:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
     e28:	83 f8 25             	cmp    $0x25,%eax
     e2b:	74 17                	je     e44 <printf+0x54>
  write(fd, &c, 1);
     e2d:	83 ec 04             	sub    $0x4,%esp
     e30:	88 5d e7             	mov    %bl,-0x19(%ebp)
     e33:	6a 01                	push   $0x1
     e35:	57                   	push   %edi
     e36:	ff 75 08             	pushl  0x8(%ebp)
     e39:	e8 45 fe ff ff       	call   c83 <write>
     e3e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
     e41:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     e44:	0f b6 1e             	movzbl (%esi),%ebx
     e47:	83 c6 01             	add    $0x1,%esi
     e4a:	84 db                	test   %bl,%bl
     e4c:	74 71                	je     ebf <printf+0xcf>
    c = fmt[i] & 0xff;
     e4e:	0f be cb             	movsbl %bl,%ecx
     e51:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     e54:	85 d2                	test   %edx,%edx
     e56:	74 c8                	je     e20 <printf+0x30>
      }
    } else if(state == '%'){
     e58:	83 fa 25             	cmp    $0x25,%edx
     e5b:	75 e7                	jne    e44 <printf+0x54>
      if(c == 'd'){
     e5d:	83 f8 64             	cmp    $0x64,%eax
     e60:	0f 84 9a 00 00 00    	je     f00 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e66:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     e6c:	83 f9 70             	cmp    $0x70,%ecx
     e6f:	74 5f                	je     ed0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e71:	83 f8 73             	cmp    $0x73,%eax
     e74:	0f 84 d6 00 00 00    	je     f50 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e7a:	83 f8 63             	cmp    $0x63,%eax
     e7d:	0f 84 8d 00 00 00    	je     f10 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     e83:	83 f8 25             	cmp    $0x25,%eax
     e86:	0f 84 b4 00 00 00    	je     f40 <printf+0x150>
  write(fd, &c, 1);
     e8c:	83 ec 04             	sub    $0x4,%esp
     e8f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     e93:	6a 01                	push   $0x1
     e95:	57                   	push   %edi
     e96:	ff 75 08             	pushl  0x8(%ebp)
     e99:	e8 e5 fd ff ff       	call   c83 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
     e9e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
     ea1:	83 c4 0c             	add    $0xc,%esp
     ea4:	6a 01                	push   $0x1
  for(i = 0; fmt[i]; i++){
     ea6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
     ea9:	57                   	push   %edi
     eaa:	ff 75 08             	pushl  0x8(%ebp)
     ead:	e8 d1 fd ff ff       	call   c83 <write>
  for(i = 0; fmt[i]; i++){
     eb2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
     eb6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
     eb9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
     ebb:	84 db                	test   %bl,%bl
     ebd:	75 8f                	jne    e4e <printf+0x5e>
    }
  }
}
     ebf:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ec2:	5b                   	pop    %ebx
     ec3:	5e                   	pop    %esi
     ec4:	5f                   	pop    %edi
     ec5:	5d                   	pop    %ebp
     ec6:	c3                   	ret    
     ec7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     ece:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
     ed0:	83 ec 0c             	sub    $0xc,%esp
     ed3:	b9 10 00 00 00       	mov    $0x10,%ecx
     ed8:	6a 00                	push   $0x0
     eda:	8b 5d d0             	mov    -0x30(%ebp),%ebx
     edd:	8b 45 08             	mov    0x8(%ebp),%eax
     ee0:	8b 13                	mov    (%ebx),%edx
     ee2:	e8 59 fe ff ff       	call   d40 <printint>
        ap++;
     ee7:	89 d8                	mov    %ebx,%eax
     ee9:	83 c4 10             	add    $0x10,%esp
      state = 0;
     eec:	31 d2                	xor    %edx,%edx
        ap++;
     eee:	83 c0 04             	add    $0x4,%eax
     ef1:	89 45 d0             	mov    %eax,-0x30(%ebp)
     ef4:	e9 4b ff ff ff       	jmp    e44 <printf+0x54>
     ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
     f00:	83 ec 0c             	sub    $0xc,%esp
     f03:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f08:	6a 01                	push   $0x1
     f0a:	eb ce                	jmp    eda <printf+0xea>
     f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
     f10:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
     f13:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
     f16:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
     f18:	6a 01                	push   $0x1
        ap++;
     f1a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
     f1d:	57                   	push   %edi
     f1e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
     f21:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     f24:	e8 5a fd ff ff       	call   c83 <write>
        ap++;
     f29:	89 5d d0             	mov    %ebx,-0x30(%ebp)
     f2c:	83 c4 10             	add    $0x10,%esp
      state = 0;
     f2f:	31 d2                	xor    %edx,%edx
     f31:	e9 0e ff ff ff       	jmp    e44 <printf+0x54>
     f36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f3d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
     f40:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
     f43:	83 ec 04             	sub    $0x4,%esp
     f46:	e9 59 ff ff ff       	jmp    ea4 <printf+0xb4>
     f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     f4f:	90                   	nop
        s = (char*)*ap;
     f50:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f53:	8b 18                	mov    (%eax),%ebx
        ap++;
     f55:	83 c0 04             	add    $0x4,%eax
     f58:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
     f5b:	85 db                	test   %ebx,%ebx
     f5d:	74 17                	je     f76 <printf+0x186>
        while(*s != 0){
     f5f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
     f62:	31 d2                	xor    %edx,%edx
        while(*s != 0){
     f64:	84 c0                	test   %al,%al
     f66:	0f 84 d8 fe ff ff    	je     e44 <printf+0x54>
     f6c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     f6f:	89 de                	mov    %ebx,%esi
     f71:	8b 5d 08             	mov    0x8(%ebp),%ebx
     f74:	eb 1a                	jmp    f90 <printf+0x1a0>
          s = "(null)";
     f76:	bb a3 14 00 00       	mov    $0x14a3,%ebx
        while(*s != 0){
     f7b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
     f7e:	b8 28 00 00 00       	mov    $0x28,%eax
     f83:	89 de                	mov    %ebx,%esi
     f85:	8b 5d 08             	mov    0x8(%ebp),%ebx
     f88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f8f:	90                   	nop
  write(fd, &c, 1);
     f90:	83 ec 04             	sub    $0x4,%esp
          s++;
     f93:	83 c6 01             	add    $0x1,%esi
     f96:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
     f99:	6a 01                	push   $0x1
     f9b:	57                   	push   %edi
     f9c:	53                   	push   %ebx
     f9d:	e8 e1 fc ff ff       	call   c83 <write>
        while(*s != 0){
     fa2:	0f b6 06             	movzbl (%esi),%eax
     fa5:	83 c4 10             	add    $0x10,%esp
     fa8:	84 c0                	test   %al,%al
     faa:	75 e4                	jne    f90 <printf+0x1a0>
      state = 0;
     fac:	8b 75 d4             	mov    -0x2c(%ebp),%esi
     faf:	31 d2                	xor    %edx,%edx
     fb1:	e9 8e fe ff ff       	jmp    e44 <printf+0x54>
     fb6:	66 90                	xchg   %ax,%ax
     fb8:	66 90                	xchg   %ax,%ax
     fba:	66 90                	xchg   %ax,%ax
     fbc:	66 90                	xchg   %ax,%ax
     fbe:	66 90                	xchg   %ax,%ax

00000fc0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fc0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fc1:	a1 00 19 00 00       	mov    0x1900,%eax
{
     fc6:	89 e5                	mov    %esp,%ebp
     fc8:	57                   	push   %edi
     fc9:	56                   	push   %esi
     fca:	53                   	push   %ebx
     fcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
     fce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     fd8:	89 c2                	mov    %eax,%edx
     fda:	8b 00                	mov    (%eax),%eax
     fdc:	39 ca                	cmp    %ecx,%edx
     fde:	73 30                	jae    1010 <free+0x50>
     fe0:	39 c1                	cmp    %eax,%ecx
     fe2:	72 04                	jb     fe8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fe4:	39 c2                	cmp    %eax,%edx
     fe6:	72 f0                	jb     fd8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
     fe8:	8b 73 fc             	mov    -0x4(%ebx),%esi
     feb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
     fee:	39 f8                	cmp    %edi,%eax
     ff0:	74 30                	je     1022 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     ff2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
     ff5:	8b 42 04             	mov    0x4(%edx),%eax
     ff8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
     ffb:	39 f1                	cmp    %esi,%ecx
     ffd:	74 3a                	je     1039 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
     fff:	89 0a                	mov    %ecx,(%edx)
  freep = p;
}
    1001:	5b                   	pop    %ebx
  freep = p;
    1002:	89 15 00 19 00 00    	mov    %edx,0x1900
}
    1008:	5e                   	pop    %esi
    1009:	5f                   	pop    %edi
    100a:	5d                   	pop    %ebp
    100b:	c3                   	ret    
    100c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1010:	39 c2                	cmp    %eax,%edx
    1012:	72 c4                	jb     fd8 <free+0x18>
    1014:	39 c1                	cmp    %eax,%ecx
    1016:	73 c0                	jae    fd8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    1018:	8b 73 fc             	mov    -0x4(%ebx),%esi
    101b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    101e:	39 f8                	cmp    %edi,%eax
    1020:	75 d0                	jne    ff2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    1022:	03 70 04             	add    0x4(%eax),%esi
    1025:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1028:	8b 02                	mov    (%edx),%eax
    102a:	8b 00                	mov    (%eax),%eax
    102c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    102f:	8b 42 04             	mov    0x4(%edx),%eax
    1032:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    1035:	39 f1                	cmp    %esi,%ecx
    1037:	75 c6                	jne    fff <free+0x3f>
    p->s.size += bp->s.size;
    1039:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    103c:	89 15 00 19 00 00    	mov    %edx,0x1900
    p->s.size += bp->s.size;
    1042:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    1045:	8b 43 f8             	mov    -0x8(%ebx),%eax
    1048:	89 02                	mov    %eax,(%edx)
}
    104a:	5b                   	pop    %ebx
    104b:	5e                   	pop    %esi
    104c:	5f                   	pop    %edi
    104d:	5d                   	pop    %ebp
    104e:	c3                   	ret    
    104f:	90                   	nop

00001050 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	57                   	push   %edi
    1054:	56                   	push   %esi
    1055:	53                   	push   %ebx
    1056:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1059:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    105c:	8b 3d 00 19 00 00    	mov    0x1900,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1062:	8d 70 07             	lea    0x7(%eax),%esi
    1065:	c1 ee 03             	shr    $0x3,%esi
    1068:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    106b:	85 ff                	test   %edi,%edi
    106d:	0f 84 ad 00 00 00    	je     1120 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1073:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
    1075:	8b 48 04             	mov    0x4(%eax),%ecx
    1078:	39 f1                	cmp    %esi,%ecx
    107a:	73 71                	jae    10ed <malloc+0x9d>
    107c:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    1082:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1087:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    108a:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
    1091:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    1094:	eb 1b                	jmp    10b1 <malloc+0x61>
    1096:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    109d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
    10a2:	8b 4a 04             	mov    0x4(%edx),%ecx
    10a5:	39 f1                	cmp    %esi,%ecx
    10a7:	73 4f                	jae    10f8 <malloc+0xa8>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    10a9:	8b 3d 00 19 00 00    	mov    0x1900,%edi
    10af:	89 d0                	mov    %edx,%eax
    10b1:	39 c7                	cmp    %eax,%edi
    10b3:	75 eb                	jne    10a0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
    10b5:	83 ec 0c             	sub    $0xc,%esp
    10b8:	ff 75 e4             	pushl  -0x1c(%ebp)
    10bb:	e8 2b fc ff ff       	call   ceb <sbrk>
  if(p == (char*)-1)
    10c0:	83 c4 10             	add    $0x10,%esp
    10c3:	83 f8 ff             	cmp    $0xffffffff,%eax
    10c6:	74 1b                	je     10e3 <malloc+0x93>
  hp->s.size = nu;
    10c8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    10cb:	83 ec 0c             	sub    $0xc,%esp
    10ce:	83 c0 08             	add    $0x8,%eax
    10d1:	50                   	push   %eax
    10d2:	e8 e9 fe ff ff       	call   fc0 <free>
  return freep;
    10d7:	a1 00 19 00 00       	mov    0x1900,%eax
      if((p = morecore(nunits)) == 0)
    10dc:	83 c4 10             	add    $0x10,%esp
    10df:	85 c0                	test   %eax,%eax
    10e1:	75 bd                	jne    10a0 <malloc+0x50>
        return 0;
  }
}
    10e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    10e6:	31 c0                	xor    %eax,%eax
}
    10e8:	5b                   	pop    %ebx
    10e9:	5e                   	pop    %esi
    10ea:	5f                   	pop    %edi
    10eb:	5d                   	pop    %ebp
    10ec:	c3                   	ret    
    if(p->s.size >= nunits){
    10ed:	89 c2                	mov    %eax,%edx
    10ef:	89 f8                	mov    %edi,%eax
    10f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    10f8:	39 ce                	cmp    %ecx,%esi
    10fa:	74 54                	je     1150 <malloc+0x100>
        p->s.size -= nunits;
    10fc:	29 f1                	sub    %esi,%ecx
    10fe:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
    1101:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
    1104:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
    1107:	a3 00 19 00 00       	mov    %eax,0x1900
}
    110c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    110f:	8d 42 08             	lea    0x8(%edx),%eax
}
    1112:	5b                   	pop    %ebx
    1113:	5e                   	pop    %esi
    1114:	5f                   	pop    %edi
    1115:	5d                   	pop    %ebp
    1116:	c3                   	ret    
    1117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    111e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
    1120:	c7 05 00 19 00 00 04 	movl   $0x1904,0x1900
    1127:	19 00 00 
    base.s.size = 0;
    112a:	bf 04 19 00 00       	mov    $0x1904,%edi
    base.s.ptr = freep = prevp = &base;
    112f:	c7 05 04 19 00 00 04 	movl   $0x1904,0x1904
    1136:	19 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1139:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
    113b:	c7 05 08 19 00 00 00 	movl   $0x0,0x1908
    1142:	00 00 00 
    if(p->s.size >= nunits){
    1145:	e9 32 ff ff ff       	jmp    107c <malloc+0x2c>
    114a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    1150:	8b 0a                	mov    (%edx),%ecx
    1152:	89 08                	mov    %ecx,(%eax)
    1154:	eb b1                	jmp    1107 <malloc+0xb7>
