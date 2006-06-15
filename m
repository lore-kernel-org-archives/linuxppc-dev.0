Return-Path: <hubert.loewenguth@thales-bm.com>
Received: from thsmsgxrt11p.thalesgroup.com (thsmsgxrt11p.thalesgroup.com
	[192.54.144.134]) by ozlabs.org (Postfix) with ESMTP id 492D167B83
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 02:04:32 +1000 (EST)
Received: from thsmsgirt21p.corp.thales (unknown [10.33.231.5])
	by thsmsgxrt11p.thalesgroup.com (Postfix) with ESMTP id 18CC83C02D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 18:04:31 +0200 (CEST)
Received: from [10.33.231.31] (10.33.231.31) by thsmsgirt21p.corp.thales
	(7.2.055.4) id 446456B6006D15CC for linuxppc-embedded@ozlabs.org;
	Thu, 15 Jun 2006 18:04:29 +0200
Received: from cnfplex.tbm.fr.thales (unknown [10.33.13.187])
	by thsmsgirt11p.corp.thales (Postfix) with ESMTP id F15363C009
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Jun 2006 18:04:30 +0200 (CEST)
Received: from [178.1.60.47] (178.1.60.47) by cnfplex.tbm.fr.thales (NPlex
	6.5.026) id 448E4D3000003694 for linuxppc-embedded@ozlabs.org;
	Thu, 15 Jun 2006 18:04:30 +0200
Message-ID: <4491850A.8000608@thales-bm.com>
Date: Thu, 15 Jun 2006 18:04:26 +0200
From: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
MIME-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: cramfs and crontab timestamp
References: <44917BF1.5070700@thales-bm.com>
In-Reply-To: <44917BF1.5070700@thales-bm.com>
Content-Type: multipart/mixed; boundary="------------030608060405030802010600"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030608060405030802010600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi
Just a little precision: the /etc "copy/mount" is done before having=20
start the cron process.
Thanks again if you have an idea.

hubert.loewenguth a =E9crit :

> hi to the community
>
> I'm not sure here is the good place for my question because it's not=20
> related to the ppc architecture, but i try.
> Here is my problem I don't understand:
> I have an embended linux 2.4.20 on a 8260 ppc with a cramfs root=20
> file-system I use since 1 year.
> Everything works fine.
> During the init process, the content of the /etc directory is copy in=20
> a tmpfs file system and then then a tmpfs file-system is mounted on=20
> /etc and fill with the old content.
> (thanks to that, I can replace after some files in the /etc by other=20
> specific files store in a little jffs part of the flash with the=20
> customer specific configurations /etc configuration files).
>
> Recently, I've decided to add cron to this platform and something very=20
> strange appear.
> My /etc/crontab file is very simple:
>
> -----------------------------------------------
> SHELL=3D/bin/sh
> PATH=3D/sbin:/bin:/usr/sbin:/usr/bin
> MAILTO=3D""
> HOME=3D/
>
> #test of cron
> * * * * * root echo date >>/tmp/essai
> -----------------------------------------------
>
> everything works fine when I boot on a nfs file-system.
> But nothing is done (/tmp/essai not created) if I boot on the cramfs=20
> file-system.
> And what is the only difference beetwen the two startup:........ the=20
> timestamp of the /etc/crontab (1/1/1970 for crontab coming from the=20
> cramfs)
>
> So I try something after having boot on cramfs:
> echo "#toto">>/etc/crontab
>
> And ones  I have done this, the cron process start to work correctly,=20
> creating and editing the /tmp/essai.
> I know that cron verify if the /etc/crontab has changed every mn, so I=20
> think this is the reason it works after, but why does it not see the=20
> first crontab file ?
> It's juste like the 1/1/1970 timestamp of /etc/crontab make him=20
> invisible by cron.
>
> Does anyone having an idea or having already encounter this kind of=20
> problem ?
> I have find nothing on the web about this or a similar problem.
>
> Thanks for any help
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

--------------030608060405030802010600
Content-Type: text/x-vcard; charset=utf-8;
 name="hubert.loewenguth.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hubert.loewenguth.vcf"

begin:vcard
fn:Hubert Loewenguth
n:Loewenguth;Hubert
org:Thales Broadcast & Multimedia
adr:;;1 rue de l'hautil;Conflans Ste Honorine;;78700;France
email;internet:hubert.loewenguth@thales-bm.com
title:Software Engineer
tel;work:01-34-90-37-56
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------030608060405030802010600--
