Message-Id: <200404010049.i310ni6P006887@ms.usish.com>
From: "Jack Liu" <Jack_liu@usish.com>
To: Ricardo Scop <scop@digitel.com.br>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Network problem: Ping is OK, Yet telnet and ftp etc is not working
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 1 Apr 2004 08:49:01 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ricardo
	Thanks. This chip is supported in linux kernel by tulip driver.
		{ 0x1317, 0x0985, PCI_ANY_ID, PCI_ANY_ID, 0, 0, COMET }
    And I compared the driver with 2.6 driver(Currently I am using
2.4.21 kernel), no related difference. So I thought this should not be
a bug in this driver(maybe). When I ftp and telnet myself, it is ok. So
the stack should be OK. So now I have no idea about the direction to
find the problem. Please advice me.

Best regards

======= 2004-03-31 15:45:00 Origianl message=======

>On Wednesday 31 March 2004 00:02, Jack Liu wrote:
>>
>>      We use ADMTek AN983B chip as our network chip. And I have
>> porting linux to this MPC8241 platform.Now I have a very strange
>> problem: If I ping my target, no answer. When I start tcpdump on
>> my target, the ping ... works fine. Since the hardware is put into
>> promiscuous mode when tcpdump is running, So I use ifconfig to put
>> NIC work in promiscuous mode. I thought it can temporarily solve the
>> problem. Now ping is OK. However When I telnet other machine, no
>> answer.And When I telnet my target, still no answer. I thought it
>> may because of firewall. So I undef CONFIG_NETFILTER in .config and
>> autoconf.h. Still the same. So what could be the problem?
>
>Well, check your interface's IP addressing for a wrong broadcast
>address; your may also have a misconfiguration in your hardware's
>drivers, related to the the MAC address and/or broadcast address
>matching.

= = = = = = = = = = = = = = = = = = = =

Best regards
Jack Liu
R&D Dept. USI(Shanghai) Inc.
Tel: +86-21-58966996x115
Fax: +86-21-58967931
Email: Jack_liu@usish.com
http://www.usi.com.tw

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
