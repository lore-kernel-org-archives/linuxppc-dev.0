Return-Path: <matvejchikov@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id 456E1DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 07:14:25 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id z59so452431pyg.27
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jan 2008 12:14:24 -0800 (PST)
Message-ID: <8496f91a0801091214n88c8d89q65beb1f160146eaa@mail.gmail.com>
Date: Wed, 9 Jan 2008 23:14:24 +0300
From: "Matvejchikov Ilya" <matvejchikov@gmail.com>
To: linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org
Subject: Re: [PATCH for 2.6.24][NET] fs_enet: check for phydev existence in
	the ethtool handlers
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: matvejchikov@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi folks!

I had the same problem too. The solution was the following:
http://www.mail-archive.com/netdev@vger.kernel.org/msg37951.html

Also have a look at the potential multicasting recovery problem in
fs_enet driver:
http://patchwork.ozlabs.org/linuxppc/patch?id=10700

Best regards,
Matvejchikov Ilya.
