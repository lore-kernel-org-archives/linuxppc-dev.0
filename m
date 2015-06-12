Return-Path: <ppc@mindchasers.com>
Received: from resqmta-ch2-02v.sys.comcast.net
 (resqmta-ch2-02v.sys.comcast.net [IPv6:2001:558:fe21:29:69:252:207:34])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D5EB1A06DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 13:29:01 +1000 (AEST)
Message-ID: <557A5000.9090207@mindchasers.com>
Date: Thu, 11 Jun 2015 23:20:32 -0400
From: Bob Cochran <ppc@mindchasers.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: mainline vs. QorIQ SDK for production with FSL SoCs...
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Please correct me if I'm mistaken and / or provide your own insight on 
the following:

I'm under the impression that it's better to develop with the mainline 
(eventually freezing for production on a stable release / branch ) than 
use the QorIQ SDK if the needed code (e.g., DPAA drivers) has been 
upstreamed and is included in the mainline.

It's my perception that it is preferable to develop with the mainline 
because there are more active open-source developers working with this 
code and actively reviewing / testing it than with the SDK and 
backported or stale drivers (e.g., WiFi)

I'm sure that there are at least dozens of FSL developers working with 
the SDK on a daily basis, but this is behind the FSL firewall, and open 
source developers, such as myself, don't have access to FSL patches 
except for every six months when a new SDK is released.

It seems to me that there will be a much better chance of hearing about 
new bugs from others and getting help debugging problems if we're using 
the mainline.  But again, the caveat is that the necessary kernel 
technology for the product is included in the mainline ( SDK contains 
some source for drivers and libraries only available under an FSL EULA ).

FYI - at this point, we're testing & developing with both the SDK 3.12 
kernel and the mainline kernel, but it would be nice to drop the former.

Lastly, for something like the p1010, we have found it to stable with 
the mainline for quite some time.

Thank you,

Bob
