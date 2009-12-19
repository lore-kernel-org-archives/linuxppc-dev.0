Return-Path: <hunter.cobbs@gmail.com>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id F097EB6EEE
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Dec 2009 13:35:19 +1100 (EST)
Received: by gxk28 with SMTP id 28so3576093gxk.9
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 18:35:17 -0800 (PST)
Subject: DWC_OTG Issues
From: Hunter Cobbs <hunter.cobbs@gmail.com>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
References: <1261176637-23912-1-git-send-email-ptyser@xes-inc.com>
Content-Type: text/plain
Date: Fri, 18 Dec 2009 20:35:15 -0600
Message-Id: <1261190115.14590.5.camel@mobiLinux>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello list.  I've run into a rather odd problem.  I seem to have a
problem with full-speed isochronous transfers across a USB2.0 Hub.  I
believe this was observed before with the general EHCI drivers in Linux.

In the latest branch of the kernel, the EHCI driver has some "Enhanced
Transaction Translation" scheduling.  This would be great for me to use
as it seems to directly address the issues I've seen.  However, I'm not
really sure on how to proceed because the DWC_OTG driver is not GPL code
while the EHCI code I'd like to use is.  Therefore, I don't believe that
I can port the Enhanced Transaction Translation routine into the DWC_OTG
driver without violating both the GPL and Synopsis's own driver.

Does anyone have a suggestion on how to proceed?
