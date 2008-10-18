Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 40CFBDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Oct 2008 19:00:47 +1100 (EST)
To: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: How can I make flash writeable?
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <BLU119-DAV13B797B2CC811E90F87406BB2D0@phx.gbl>
References: <mailman.1.1224291602.14390.linuxppc-embedded@ozlabs.org>
	<BLU119-DAV13B797B2CC811E90F87406BB2D0@phx.gbl>
Date: Sat, 18 Oct 2008 09:53:16 +0200
Message-Id: <20081018075316.11AB0835697A@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear "Duy-Ky Nguyen",

In message <BLU119-DAV13B797B2CC811E90F87406BB2D0@phx.gbl> you wrote:
> 
> I guess you want to have RW filesystem for your Linux target.
> If that's the case you need to have root filesystem as JFFS2.

This is not correct. You can use a read-only root file system combined
with additionala ,writable file systems.

> There's a document MPC8313E-RDB BSP User's Guide comes with the MPC8313E-RDB 
> package.
> It has all info for several filesystems like NFS (network), Ramdisk 
> (Read-Only), and JFFS2 (Read/Write)

That's incorrect, either. A ramdisk is usually writable (unless you
mount it read-only, which would be very unusuak).

See also
http://www.denx.de/wiki/view/DULG/RootFileSystemDesignAndBuilding

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To get something done, a committee should consist  of  no  more  than
three men, two of them absent.
