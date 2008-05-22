Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 48916DE129
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 07:15:57 +1000 (EST)
Date: Thu, 22 May 2008 17:15:54 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Ron Madrid" <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
Message-ID: <20080522171554.6089e05a@lappy.seanm.ca>
In-Reply-To: <606394.37977.qm@web83507.mail.sp1.yahoo.com>
References: <606394.37977.qm@web83507.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 May 2008 13:36:32 -0700 (PDT)
"Ron Madrid" <ron_madrid@sbcglobal.net> wrote:

> I'm trying to make new directories, create files, save
> changes to files, etc. and when I reboot my changes
> are not being saved.  I'm sorry if this is vague, but
> I haven't run into this problem before in previous
> kernels.  I'm using 2.6.25 and my configuration is
> very similar to mpc8313erdb_defconfig, with changes to
> include NAND support as my flash device is a NAND. 
> Also, my dts is very similar to mpc8313erdb.dts as
> well.  I don't know where to start looking for the
> problem as there is no error.  Here is what is printed
> on boot.

Are you sure the mount is working? What does the output of mount say?

Cheers,
  Sean
