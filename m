Message-ID: <40EABF09.30307@intracom.gr>
Date: Tue, 06 Jul 2004 18:02:33 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Pedro Aguilar <paguilar@junkerhq.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling error, kernel 2.6.7
References: <48147.127.0.0.1.1089123928.squirrel@junkerhq.net>
In-Reply-To: <48147.127.0.0.1.1089123928.squirrel@junkerhq.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Pedro Aguilar wrote:

>Hi,
>
>I have a FADS board with a MPC859T running a 2.4.17 kernel. I would like
>to make an upgrade to the 2.6.7 kernel supporting HDLC and ATM.
>
>The problem is when I'm compiling the new kernel, it shows an error
>message when compiling the uart.c file (the output is at the end of this
>mail).
>It seems that an include file is missing. Could you give some advise please?
>
>I'm using ELDK 3.0 from DENX.
>
>Additionally, I would like to know:
>- Is there any support in Linux in MPC8xx for "Multi-protocol over ATM"
>and "Multi-protocol over Frame Relay"?
>- Is there any support in Linux in MPC8xx for HDLC?
>
>Thanks in advance.
>
>Pedro
>
>---
>
>  CC      arch/ppc/8xx_io/uart.o
>arch/ppc/8xx_io/uart.c:82: warning: type defaults to `int' in declaration
>of `DECLARE_TASK_QUEUE'
>arch/ppc/8xx_io/uart.c:82: warning: parameter names (without types) in
>function declaration
>arch/ppc/8xx_io/uart.c: In function `serial_console_device':
>arch/ppc/8xx_io/uart.c:145: storage class specified for parameter
>`rs_table' arch/ppc/8xx_io/uart.c:145: parameter `rs_table' is initialized
>arch/ppc/8xx_io/uart.c:148: warning: braces around scalar initializer
>arch/ppc/8xx_io/uart.c:148: warning: (near initialization for `rs_table')
>arch/ppc/8xx_io/uart.c:148: warning: excess elements in scalar initializer
>arch/ppc/8xx_io/uart.c:148: warning: (near initialization for `rs_table')
>arch/ppc/8xx_io/uart.c:148: warning: excess elements in scalar initializer
>arch/ppc/8xx_io/uart.c:148: warning: (near initialization for `rs_table')
>arch/ppc/8xx_io/uart.c:148: warning: excess elements in scalar initializer
>arch/ppc/8xx_io/uart.c:148: warning: (near initialization for `rs_table')
>arch/ppc/8xx_io/uart.c:148: warning: excess elements in scalar initializer
>arch/ppc/8xx_io/uart.c:148: warning: (near initialization for `rs_table')
>arch/ppc/8xx_io/uart.c:148: warning: excess elements in scalar initializer
>arch/ppc/8xx_io/uart.c:148: warning: (near initialization for `rs_table')
>arch/ppc/8xx_io/uart.c:193: field `tqueue' has incomplete type
>arch/ppc/8xx_io/uart.c:194: field `tqueue_hangup' has incomplete type
>arch/ppc/8xx_io/uart.c:210: warning: structure defined inside parms
>arch/ppc/8xx_io/uart.c:210: storage class specified for parameter
>`ser_info_t'
>arch/ppc/8xx_io/uart.c:212: storage class specified for parameter
>`sercons' arch/ppc/8xx_io/uart.c:212: parameter `sercons' is initialized
>arch/ppc/8xx_io/uart.c:221: parse error before '*' token
>arch/ppc/8xx_io/uart.c:221: storage class specified for parameter
>`change_speed'
>arch/ppc/8xx_io/uart.c:221: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c:222: storage class specified for
>parameter
>`rs_8xx_wait_until_sent'
>arch/ppc/8xx_io/uart.c:224: parse error before '*' token
>arch/ppc/8xx_io/uart.c:226: storage class specified for parameter
>`serial_paranoia_check'
>arch/ppc/8xx_io/uart.c:226: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c:226: warning: `always_inline' attribute
>ignored arch/ppc/8xx_io/uart.c:226: warning: `always_inline' attribute
>ignored arch/ppc/8xx_io/uart.c:145: parm types given both in parmlist and
>separately arch/ppc/8xx_io/uart.c:233: `info' undeclared (first use in
>this function) arch/ppc/8xx_io/uart.c:233: (Each undeclared identifier is
>reported only once arch/ppc/8xx_io/uart.c:233: for each function it
>appears in.)
>arch/ppc/8xx_io/uart.c:234: `name' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:234: `routine' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:235: warning: return makes pointer from
>integer without a cast
>arch/ppc/8xx_io/uart.c:239: warning: return makes pointer from integer
>without a cast
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_stop':
>arch/ppc/8xx_io/uart.c:265: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:265: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:265: parse error before ')' token
>arch/ppc/8xx_io/uart.c:271: warning: implicit declaration of function
>`serial_paranoia_check'
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_start':
>arch/ppc/8xx_io/uart.c:289: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:289: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:289: parse error before ')' token
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:336: parse error before '*' token
>arch/ppc/8xx_io/uart.c:338: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `rs_sched_event':
>arch/ppc/8xx_io/uart.c:339: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:339: `event' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:340: warning: implicit declaration of
>function `queue_task'
>arch/ppc/8xx_io/uart.c:340: `tq_serial' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:341: warning: implicit declaration of function
>`mark_bh'
>arch/ppc/8xx_io/uart.c:341: `SERIAL_BH' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:344: parse error before '*' token
>arch/ppc/8xx_io/uart.c:345: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `receive_chars':
>arch/ppc/8xx_io/uart.c:346: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:501: structure has no member named `tqueue'
>arch/ppc/8xx_io/uart.c:501: `tq_timer' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:504: parse error before '*' token
>arch/ppc/8xx_io/uart.c:505: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `receive_break':
>arch/ppc/8xx_io/uart.c:506: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:529: structure has no member named `tqueue'
>arch/ppc/8xx_io/uart.c:529: `tq_timer' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:532: parse error before '*' token
>arch/ppc/8xx_io/uart.c:533: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `transmit_chars':
>arch/ppc/8xx_io/uart.c:535: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_interrupt':
>arch/ppc/8xx_io/uart.c:622: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:622: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:626: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `do_serial_bh':
>arch/ppc/8xx_io/uart.c:683: warning: implicit declaration of function
>`run_task_queue'
>arch/ppc/8xx_io/uart.c:683: `tq_serial' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: In function `do_softint':
>arch/ppc/8xx_io/uart.c:688: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:688: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:688: parse error before ')' token
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:728: parse error before '*' token
>arch/ppc/8xx_io/uart.c:729: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `startup':
>arch/ppc/8xx_io/uart.c:733: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:771: warning: implicit declaration of function
>`change_speed'
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:817: parse error before '*' token
>arch/ppc/8xx_io/uart.c:818: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `shutdown':
>arch/ppc/8xx_io/uart.c:825: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:845: `rs_table' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:875: parse error before '*' token
>arch/ppc/8xx_io/uart.c:876: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c:876: warning: `change_speed' was declared
>implicitly `extern' and later `static'
>arch/ppc/8xx_io/uart.c:771: warning: previous declaration of
>`change_speed' arch/ppc/8xx_io/uart.c:876: warning: type mismatch with
>previous implicit declaration
>arch/ppc/8xx_io/uart.c:771: warning: previous implicit declaration of
>`change_speed'
>arch/ppc/8xx_io/uart.c:876: warning: `change_speed' was previously
>implicitly declared to return `int'
>arch/ppc/8xx_io/uart.c: In function `change_speed':
>arch/ppc/8xx_io/uart.c:885: `info' undeclared (first use in this function)
>arch/ppc/8xx_io/uart.c:1020: `rs_table' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_put_char':
>arch/ppc/8xx_io/uart.c:1027: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1027: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1027: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_write':
>arch/ppc/8xx_io/uart.c:1060: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1060: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1060: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_write_room':
>arch/ppc/8xx_io/uart.c:1120: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1120: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1120: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_chars_in_buffer':
>arch/ppc/8xx_io/uart.c:1141: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1141: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1141: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_flush_buffer':
>arch/ppc/8xx_io/uart.c:1150: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1150: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1150: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_send_xchar':
>arch/ppc/8xx_io/uart.c:1174: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1174: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1174: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_throttle':
>arch/ppc/8xx_io/uart.c:1207: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1207: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1207: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_unthrottle':
>arch/ppc/8xx_io/uart.c:1233: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1233: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1233: parse error before ')' token
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1289: parse error before '*' token
>arch/ppc/8xx_io/uart.c:1290: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `get_modem_info':
>arch/ppc/8xx_io/uart.c:1310: `value' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1310: warning: type defaults to `int' in
>declaration of `__pu_addr'
>arch/ppc/8xx_io/uart.c:1310: warning: type defaults to `int' in
>declaration of `type name'
>arch/ppc/8xx_io/uart.c:1310: warning: type defaults to `int' in
>declaration of `type name'
>arch/ppc/8xx_io/uart.c:1310: warning: type defaults to `int' in
>declaration of `type name'
>arch/ppc/8xx_io/uart.c:1310: warning: type defaults to `int' in
>declaration of `type name'
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1313: parse error before '*' token
>arch/ppc/8xx_io/uart.c:1315: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `set_modem_info':
>arch/ppc/8xx_io/uart.c:1319: `value' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1319: warning: type defaults to `int' in
>declaration of `__gu_addr'
>arch/ppc/8xx_io/uart.c:1319: warning: type defaults to `int' in
>declaration of `type name'
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1389: parse error before '*' token
>arch/ppc/8xx_io/uart.c:1390: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `begin_break':
>arch/ppc/8xx_io/uart.c:1397: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1406: parse error before '*' token
>arch/ppc/8xx_io/uart.c:1407: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `end_break':
>arch/ppc/8xx_io/uart.c:1414: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1426: parse error before '*' token
>arch/ppc/8xx_io/uart.c:1427: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `send_break':
>arch/ppc/8xx_io/uart.c:1432: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1433: `duration' undeclared (first use in
>this function)
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_ioctl':
>arch/ppc/8xx_io/uart.c:1445: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1445: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1445: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_set_termios':
>arch/ppc/8xx_io/uart.c:1583: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1583: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1583: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_close':
>arch/ppc/8xx_io/uart.c:1648: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1648: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1648: parse error before ')' token
>arch/ppc/8xx_io/uart.c:1725: warning: implicit declaration of function
>`rs_8xx_wait_until_sent'
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1751: warning: `rs_8xx_wait_until_sent' was
>declared implicitly `extern' and later `static'
>arch/ppc/8xx_io/uart.c:1725: warning: previous declaration of
>`rs_8xx_wait_until_sent'
>arch/ppc/8xx_io/uart.c:1751: warning: type mismatch with previous implicit
>declaration
>arch/ppc/8xx_io/uart.c:1725: warning: previous implicit declaration of
>`rs_8xx_wait_until_sent'
>arch/ppc/8xx_io/uart.c:1751: warning: `rs_8xx_wait_until_sent' was
>previously implicitly declared to return `int'
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_wait_until_sent':
>arch/ppc/8xx_io/uart.c:1752: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1752: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1752: parse error before ')' token
>arch/ppc/8xx_io/uart.c:1776: warning: comparison of distinct pointer types
>lacks a cast
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_hangup':
>arch/ppc/8xx_io/uart.c:1822: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1822: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1822: parse error before ')' token
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1845: parse error before "ser_info_t"
>arch/ppc/8xx_io/uart.c:1846: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `block_til_ready':
>arch/ppc/8xx_io/uart.c:1850: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1858: `filp' undeclared (first use in
>this function) arch/ppc/8xx_io/uart.c:1879: `tty' undeclared (first use in
>this function) arch/ppc/8xx_io/uart.c:1850: warning: unused variable
>`state'
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:1957: parse error before "ser_info_t"
>arch/ppc/8xx_io/uart.c:1958: warning: function declaration isn't a
>prototype arch/ppc/8xx_io/uart.c: In function `get_async_struct':
>arch/ppc/8xx_io/uart.c:1961: `rs_table' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1961: `line' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1964: `ret_info' undeclared (first use in
>this function)
>arch/ppc/8xx_io/uart.c:1964: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1964: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_open':
>arch/ppc/8xx_io/uart.c:1980: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:1980: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:1984: `rs_table' undeclared (first use in
>this function)
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_read_proc':
>arch/ppc/8xx_io/uart.c:2110: `rs_table' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:2158: parse error before "consinfo"
>arch/ppc/8xx_io/uart.c:2158: warning: type defaults to `int' in
>declaration of `consinfo'
>arch/ppc/8xx_io/uart.c:2158: warning: data definition has no type or
>storage class
>arch/ppc/8xx_io/uart.c: In function `my_console_write':
>arch/ppc/8xx_io/uart.c:2168: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:2168: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:2174: `rs_table' undeclared (first use in
>this function)
>arch/ppc/8xx_io/uart.c:2180: parse error before ')' token
>arch/ppc/8xx_io/uart.c: In function `my_console_wait_key':
>arch/ppc/8xx_io/uart.c:2295: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:2295: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:2300: `rs_table' undeclared (first use in
>this function)
>arch/ppc/8xx_io/uart.c:2310: parse error before ')' token
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:2448: redefinition of `serial_console_device'
>arch/ppc/8xx_io/uart.c:226: `serial_console_device' previously defined
>here arch/ppc/8xx_io/uart.c: In function `console_8xx_init':
>arch/ppc/8xx_io/uart.c:2458: `sercons' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:2460: warning: initialization from incompatible
>pointer type
>arch/ppc/8xx_io/uart.c: In function `rs_8xx_init':
>arch/ppc/8xx_io/uart.c:2493: `ser_info_t' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:2493: `info' undeclared (first use in this
>function) arch/ppc/8xx_io/uart.c:2505: `rs_table' undeclared (first use in
>this function)
>arch/ppc/8xx_io/uart.c:2509: warning: implicit declaration of function
>`init_bh'
>arch/ppc/8xx_io/uart.c:2509: `SERIAL_BH' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:2583: warning: value computed is not used
>arch/ppc/8xx_io/uart.c: In function `serial_console_setup':
>arch/ppc/8xx_io/uart.c:2868: `rs_table' undeclared (first use in this
>function)
>arch/ppc/8xx_io/uart.c:2906: request for member `rx_va_base' in something
>not a structure or union
>arch/ppc/8xx_io/uart.c:2907: request for member `rx_bd_base' in something
>not a structure or union
>arch/ppc/8xx_io/uart.c:2908: request for member `tx_va_base' in something
>not a structure or union
>arch/ppc/8xx_io/uart.c:2909: request for member `tx_bd_base' in something
>not a structure or union
>arch/ppc/8xx_io/uart.c: At top level:
>arch/ppc/8xx_io/uart.c:82: warning: `DECLARE_TASK_QUEUE' declared `static'
>but never defined
>arch/ppc/8xx_io/uart.c:2292: warning: `my_console_wait_key' defined but
>not used
>arch/ppc/8xx_io/uart.c:2448: warning: `serial_console_device' defined but
>not used
>gmake[1]: *** [arch/ppc/8xx_io/uart.o] Error 1
>gmake: *** [arch/ppc/8xx_io] Error 2
>
>
>
>
>
>
>
Hold your horses.

8xx is not yet working in 2.6.

Work is in progress...

Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
