Message-ID: <3FBA11AC.8090408@g-house.de>
Date: Tue, 18 Nov 2003 13:33:48 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Cc: Tom Rini <trini@kernel.crashing.org>
Subject: Re: ppc32 lockups with 2.6
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de> <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net> <3FB2D757.1010304@g-house.de> <20031113174745.GA11560@ip68-0-152-218.tc.ph.cox.net> <3FB41A14.3040108@g-house.de>
In-Reply-To: <3FB41A14.3040108@g-house.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

2.6.0-test9 with kgdb compiled fine then, but i did not get a serial
cable yet.

i took another approach, i wanted to see since when the lockups occur. i
was testing 2.5 kernels on i386 and alpha, but i've started to test 2.6
on ppc pretty late. so, what i see is, that i can boot to 2.6.0-test4
(former kernel version down to 2.5.72 did not even compile cleanly).
i can set up eth0 and i can watch "ifconfig eth0" then. "ping
192.168.1.10" (eth0) is working, but routing seems broken. (i have to
show the details later on).

"ping 192.168.1.11" fails and print a lot to the syslog as you can see
in line 581 in:

http://nerdbynature.de/bits/sheep/network/2.6.0-test4/messages.gz

during bootup i had to use SYSREQ-E to quit a process, that wanted to
use the ethernet-device (snort?)
(SYSREQ-K should have been enough perhaps).

here's the config for this 2.6.0-test4 kernel
http://nerdbynature.de/bits/sheep/network/2.6.0-test4/config

i will go on with 2.6.0-tes5 now....

Thank you,
Christian.
--
BOFH excuse #229:

wrong polarity of neutron flow


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
