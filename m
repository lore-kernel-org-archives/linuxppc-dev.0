Return-Path: <tmaenner@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 437C7DDF78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 02:01:47 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so673909ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 08:01:45 -0700 (PDT)
Message-ID: <f001edbb0703220801m68622465j397a007bb85570cd@mail.gmail.com>
Date: Thu, 22 Mar 2007 08:01:44 -0700
From: "Thomas Maenner" <tmaenner@aehr.com>
Sender: tmaenner@gmail.com
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: TQM 860L, 64MB RAM, ELDK4.1, TQM860L, Kernel 2.6.19
In-Reply-To: <20070322074052.34DD535260B@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200703212044.40611.tmaenner@aehr.com>
	<20070322074052.34DD535260B@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks Wolfgang for your reply,

You're right, I can not really tell, whether it's frozen since I don't
have a BDM...
I'll try the console command you suggested, which I haven't had to use
before (U-boot 1.1.2 and older, Kernel 2.4, older ELDK)

Thanks
Tom

On 3/22/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <200703212044.40611.tmaenner@aehr.com> you wrote:
> >
> > need from the experts on the list again.
> > The CPU freezes after the ramdisk gets loaded!
>
> Does it really  freeze?  I  mean,  did  you  verify  this  witha  BDM
> debugger,  or  do you just see no further output on the console? Note
> that these are two fundamentally different things...
>
> > u-boot environment:
> > => printenv
> > bootcmd=run flash_self
> > bootdelay=5
> > baudrate=115200
> > loads_echo=1
> > preboot=echo;echo TQ-Module Bootloader for ABTS;echo Type "run flash_nfs" to
> > mount root filesystem over NFS;echo
> > netdev=eth0
> > nfsargs=setenv bootargs root=/dev/nfs rw nfsroot=${serverip}:${rootpath}
> > addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:
> > ${netmask}:${hostname}:${netdev}:off panic=1
> > flash_nfs=run nfsargs addip;bootm ${kernel_addr}
> > flash_self=run ramargs addip;bootm ${kernel_addr} ${ramdisk_addr}
> > net_nfs=tftp 200000 ${bootfile};run nfsargs addip;bootm
> > rootpath=/opt/eldk/ppc_8xx
> > kernel_addr=40040000
> > serial#=TQM860LDDBA3-P80.210 11090659
> > ethaddr=00:D0:93:04:DC:1B
> > eth1addr=00:D0:93:04:DC:1B
> > ethprime=FEC ETHERNET
> > bootfile=/TQM860L/uImage
> > fileaddr=100000
> > ramdisk_addr=40200000
> > ramargs=setenv bootargs ramdisk_size=6144 root=/dev/ram rw
> > initrd_high=30000000
> > stdin=serial
> > stdout=serial
> > stderr=serial
> > ethact=FEC ETHERNET
> > bootcount=39
>
> I don't see you passing any console=ttyCPM0 argument here?
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
> Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Not one hundred percent efficient, of course ... but nothing ever is.
>         -- Kirk, "Metamorphosis", stardate 3219.8
>



-- 
Thomas Maenner
Engineering Project Manager
AEHR Test Systems
400 Kato Terrace
Fremont, CA 94539
Phone: +1-510-623-9400x323
Cell: +1-925-389-6653
Fax: +1-510-623-9450
E-Mail: mailto:tmaenner@aehr.com
