Message-ID: <396D419D.F616A8DA@m2tech.co.nz>
Date: Thu, 13 Jul 2000 16:12:13 +1200
From: ben bodley <benb@m2tech.co.nz>
MIME-Version: 1.0
To: xuwentao@cn.ibm.com
CC: mailing list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Why eth0 does not work
References: <4825691B.00152176.00@d73mta06.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


xuwentao@cn.ibm.com wrote:

> Currently I only modify ppc4xx_pic_init() to init IRQ 20 and 26, which is
> used by
> ttys00 and eth0. That error occurs because my CPU is a ppc401 not a 405gp.
>
> I have exported /opt/hardhat/devkit/ppc/8xx/target_ftest4 according
> instructions from
> mvista. The output is broken into 2 lines.
>
> BTW, I disabled the loopback in the config file, and the msg "lo is down'
> still
> appears.
>
> I start the tcpdump at the server, I found that the server recieved many
> ARP packets
> issued from the linux box(7.1.1.5) looking for the server(7.1.1.21). It
> seems that
> the box can not resolve 7.1.1.21 (can not read MAC addr, as Ben said).
>
> Xu Wentao
> IBM China Research Lab
> Tel:          (86-10)  62986677-216
> Internet:    xuwentao@cn.ibm.com

if you could send the tcpdump output that would help.. dont worry about the
'device lo is down' message, it wont effect any of your ethernet work.. i
think you will need to modify the board info struct, and get the proper mac
address from it.. maybe what is happening is you are configuring linux to use
a mac address different than the actual hardware setting??

also, have you set the io pins correctly?? the stb chip needs a lot of gpio
setting up to work properly.. you also need to configure the xilinx fpga's to
select input from the ethernet mac, etc..

cheers,

ben


--
/\\------------------------------------------------------------------
:::::::::::..ben.b..m2technologyltd.nz..64.9.4448307.130..:::::::::::


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
