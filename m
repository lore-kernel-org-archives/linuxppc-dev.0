Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E37B7DDF51
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 08:30:41 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 02 Feb 2009 22:21:39 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090202212139.69160@gmx.net>
MIME-Version: 1.0
Subject: AmigaOne platform patches v2
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi!

I updated the patches for the AmigaOne platform based on your comments.
The following changes were made compared to v1:

setup.c:
- replaced "model" entry in /proc/cpuinfo with a "vendor" entry
- replaced cache flushing code in amigaone_restart() with call to
__flush_disable_L1()
- removed feature fixup code in amigaone_probe(): only AmigaOnes with
G3 can run an unmodified kernel for now, until the PPC32 startup code
is reorganized to do the feature fixup after probe_machine()

amigaone.dts:
- removed nodes for probeable PCI devices
- removed device_type properties that are not used by the kernel

I didn't add an interrupt-map property yet. I would have to make 3
versions of the dts, if this is required.

Thanks!

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
