Return-Path: <ternaryd@gmail.com>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0248D2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 19:11:26 +1100 (EST)
Received: by mail-ee0-f45.google.com with SMTP id d49so2347655eek.18
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2013 00:11:23 -0800 (PST)
Date: Tue, 15 Jan 2013 09:11:19 +0100
From: ternaryd <ternaryd@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: device tree entry for tsi148
Message-ID: <20130115091119.41e2a0f9@vesta>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm trying to install linux on an e500v2 board with the tsi148
VME-Bridge, but got stuck. Now it seems that I need to include
information regarding this bridge into the .dts-file, but can't figure
out how. Maybe somebody on this list could post the tsi148-specific
part of a device tree, which I could use as a guide line?

Please CC me, as I'm not on this list.

Thanks in advance,

-- 
Christoph
