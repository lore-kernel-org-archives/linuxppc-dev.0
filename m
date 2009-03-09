Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DBF95DE0AE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 08:30:37 +1100 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 09 Mar 2009 22:30:34 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090309213034.192330@gmx.net>
MIME-Version: 1.0
Subject: Does DRI/DRM still work on non-coherent DMA platforms?
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I heard rumors that DRI doesn't work on SAM440EP (onboard Radeon GPU)
boards. I had DRI halfway working on my AmigaOne (Radeon 9250) with an
early release candidate of the 2.6.25 kernel and IIRC this patch here
(manually applied):
http://kerneltrap.org/index.php?q=mailarchive/git-commits-head/2008/3/30/1301044

I just tested DRI again on my A1 (I don't have a SAM board) with
v2.6.29-rc6 and the machine looks up while starting the X server.
Curiously DRI seems to work, if I specify "udbg-immortal" on the
kernel command line and enable DRM debugging.
Did anyone try out DRI on a non-coherent DMA PPC platform and can
confirm that it still works?

best regards,

Gerhard

-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört? Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger01
