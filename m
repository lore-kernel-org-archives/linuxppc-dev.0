MIME-Version: 1.0
Message-Id: <38DAAFB4.19073@mta5>
Date: Fri, 24 Mar 2000 07:58:44 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Steven Tarr <tarr@lucent.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: About rs232 on motorola mpc8260 ads board
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>David--
>
>I've been using the MPC8260ADS board(ENGversion) for about 3months.
>I have Port1(SCC1) connectedtoa SUN tty port and have had no problems.
>There is demo oe on the Motorola site that show you how to program theport.As to the ranges of outpuut voltages,I have not measured them.
>
>Try
>http://www.mot-sps.com/products/microprocessors/32_bit/mpc8000/mpc8260_devtools.html
>cheers--
>SteveTarr
>
>
I am using the pilot version of the ads board,and  indeed run the
init8260 example from mot web site.How do you connect the pins?
According to ads manual,pin 2 from connector is tx,pin 3 is rx,
,and i also connect pin 4( DTR connect with SCC1 CD on PC14) with
pin 6(DSR).The output volatege is 0-5V.but the logic is 232.
I think it should be i had not  connectted the pins  correctly?
At the time of writing,when i reading the ads manual,i found CTS(pin 8) connect to SCC1's RTS on PD29.But the Init program did not program
this pin?How about eng version's connection?Should i program this pin?

>zzhwrote:
>

>>**Sentviathelinuxppc-embeddedmaillist.Seehttp://lists.linuxppc.org/
>--
>SteveTarr
>tarr@lucent.com
>303-538-4056
>
>


_____________________________________________
首都在线--中国人的网上家园 http://www.263.net
@263.net中国最大的在线邮局 http://freemail.263.net

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
