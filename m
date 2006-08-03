Return-Path: <wd@denx.de>
To: Matthew McClintock <msm@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Aug 2006 15:12:18 CDT."
	<1154635939.5094.37.camel@localhost>
Date: Thu, 03 Aug 2006 22:23:25 +0200
Sender: wd@denx.de
Message-Id: <20060803202325.4566C352660@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1154635939.5094.37.camel@localhost> you wrote:
>
> I'm referring to the zImage target as what the current method does. My

This is highly confusing. zImage is a special make target, which  has
NOTHING  to  do with U-Boot. Please don't use this name in the U-Boot
context unleass you really mean it.

> The zImage can have a compressed kernel section or an uncompressed

I stop parsing here. zImage has *nothing* to do with this topic.

> As a side note, the final cuImage (which is a U-Boot image) can be
> either compressed or uncompressed. That is irrelevant. The major point
> is the kernel section within the cuImage is not compressed, and the
> final cuImage is in fact a U-Boot image which can be started with the
> 'bootm' command from within U-Boot.

As explained in a previous message, you should change  the  order  of
parts  (sections?)  in  your  image.  Put the kernel image first, and
attach your stuff at the end. This allows to use standard mechanisms,
keep all the existing flexibility and avoid useless memory copy.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Ninety-Ninety Rule of Project Schedules:
        The first ninety percent of the task takes ninety percent of
the time, and the last ten percent takes the other ninety percent.
