Return-Path: <Clive.Jenkins@xerox.com>
Received: from USA7109MR001.ACS-INC.COM (usa7109mr001.acs-inc.com
 [63.101.151.9])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (Client CN "usa7109mr.acs-inc.com",
 Issuer "USERTrust Legacy Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 417AFB700C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2012 21:26:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: userspace o/p to kernel buffer
Date: Fri, 13 Apr 2012 12:15:06 +0100
Message-ID: <929D3CED81F34E43887A393170D66FB9060771CF@GBRSUN01MS002.eu.xerox.net>
In-Reply-To: <BLU124-W23D62A308B2F33EC51A3D2B43B0@phx.gbl>
References: <BLU124-W23D62A308B2F33EC51A3D2B43B0@phx.gbl>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: Sumesh Kaana <sumeshkkn@hotmail.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> How do I capture all the output of user-space programs into
> a kernel buffer so that I can later read it using debugger ?
>=A0My board doesn't have a console (no serial, no network).

Assuming you are using a shell to start your user-space
programs, you could easily redirect output to /dev/kmsg
then find it in the dmesg buffer afterwards. You may need
to increase the buffer size.

Clive
