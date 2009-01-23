Return-Path: <johns.daniel@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 8D72DDDF9D
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 02:05:17 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so1162885qwb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jan 2009 07:05:16 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 23 Jan 2009 09:05:16 -0600
Message-ID: <ba5d9360901230705v750a958au7eeaa923aadc41ad@mail.gmail.com>
Subject: Common kernel image for e300 and e500v2
From: Johns Daniel <johns.daniel@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is it possible -- and prudent -- to use a single kernel binary image
for two similar boards, one based on an e300 core and the other on an
e500v2 core?

I was surprised to see that the e500v2-targeted toolchain did build
the kernel for the e300 board just fine. Don't know whether this will
always be true?

The next logical step was to configure and customize the kernel just
right so that a single binary image will work on both boards. I am not
sure this is possible -- and, even if possible, whether this is
kosher!

Would love to hear the technical nuances involved with this...

-- Johns
