Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id E44082BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Nov 2004 10:27:43 +1100 (EST)
To: Dieter Wirtz <dieter.wirtz@gmx.net>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 22 Nov 2004 20:38:14 +0100."
	<41A24026.5070908@gmx.net>
Date: Mon, 22 Nov 2004 23:26:45 +0100
Sender: wd@denx.de
Message-Id: <20041122222650.71E09C1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: compiling ELDK3 microwindows source paket 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <41A24026.5070908@gmx.net> you wrote:
> 
> I want to rebuild the ELDK3 (www.denx.de) microwindows source paket 
> (host system: i386 pc running SUSE 9.0; target system: embedded ppc405; 
> CROSS_COMPILE=ppc_4xx-).
> 
> For it I installed the source in the ELDK3 directory and tried to 
> rebuild the paket with  ${CROSS_COMPILE}rpmbuild -ba microwindows.spec. 
> This gave some errors because the host and not the cross compiler was used.

There is a detailed description how to do this inthe ELDK manual;
please see
http://www.denx.de/twiki/bin/view/DULG/ELDKRebuildingComponents#Section_3.7.2.

Please pay special attention to the two requirements shown at the end
of this paragraph.

> After I changed the file microwindows-0.90-config.ppc.patch from

Don't do this, it will break the build.

> What can it be?

User error. Please RTFM.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There's only one kind of woman ..." "Or man, for  that  matter.  You
either believe in yourself or you don't."
	-- Kirk and Harry Mudd, "Mudd's Women", stardate 1330.1
