Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id 9BAFFDDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 02:27:20 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2122857wag
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 09:27:19 -0700 (PDT)
Message-ID: <9e4733910708130927l70163a80vf0362ee8649a6c29@mail.gmail.com>
Date: Mon, 13 Aug 2007 12:27:19 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200 and Bestcomm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We're starting a new MPC5200 project and I'm trying to track down the
best kernel to start from. Is Sylvain's tree at
http://www.246tnt.com/mpc52xx/ a good place to start? The git URLs
from the web page don't work. Everything 5200 related in the trees at
Secret Labs already appears to be merged.

Most of this work also appears to be in the Open Embedded tree's Ekifa
support. Is that a better place to start?

I need to get multiple I2S ports running with DMA.

-- 
Jon Smirl
jonsmirl@gmail.com
