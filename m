Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh Jagota <j.rakesh@gdatech.co.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: JFFS2 for IBM ppc405  based Target board
Date: Mon, 21 Apr 2003 19:52:43 +0530
References: <slemye5aoor48df.210420031014@gda-server> <000f01c307cb$6a614160$af85efcb@qhavm>
In-Reply-To: <000f01c307cb$6a614160$af85efcb@qhavm>
MIME-Version: 1.0
Message-ID: <gmf3nqpyrwcsb20.210420031943@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I have downloaded the source and I have installed it my host machine as per
the instruction. I am not able to compile it for jffs2, but its getting
compiled for jffs, using the following command:

In the Makefile I have chnaged the linux directory as per my target sourec
directory for IBM Power PC 405.

make jffs


After that I have complied the "util" using "make" command.
I am getting confused , to get the final image. I am using the following
command, can you pl tell em whether I am doing it right or wrong:

====================================================================
[root@Rakesh mtd]# ./mkfs.jffs -d /home/test/mtd/fs/jffs -o /tmp/jffs.image
====================================================================

and


====================================================================
[root@Rakesh mtd]# ./mkfs.jffs2 -d /home/test/mtd/fs/jffs -o /tmp/jffs.image1
====================================================================

With the first option I am getting the jffs.image of  1705432Kb and with the
second option , when I use mkfs.jffs2, I am getting the jffs.image1 of size
657876KB


Can anyone suggest me whether I am doing  it right or not. And can I use
anyone of the command like mkfs.jffs or mkfs.jffs2.


Thanks & Regards,

Rakesh

On Monday 21 April 2003 11:30 am, you wrote:
> mkfs.jffs2

>

> ----- Original Message -----

> From: "Rakesh Jagota" <j.rakesh@gdatech.co.in>

> To: <linuxppc-embedded@lists.linuxppc.org>

> Sent: Monday, April 21, 2003 1:54 PM

> Subject: JFFS2 for IBM ppc405 based Target board

>

>

>
> >

> > Hi all,

> > I am using montavista linux priviewkit 2.4.17. Currently I am using nfs.
> > How
 can I create jffs2 file fyftem. I am working with IBM power pc 405.
> > Can anyone suggest me, how to create the jffs2 filesystem for PPC 405.
> > Thanks & Regards,

> >

> > Rakesh

> >

> >


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
