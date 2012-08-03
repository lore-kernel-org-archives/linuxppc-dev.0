Return-Path: <Luis_Gustavo@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 36F802C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Aug 2012 02:00:50 +1000 (EST)
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1SxKIy-0003pe-8u from Luis_Gustavo@mentor.com
 for linuxppc-dev@lists.ozlabs.org; Fri, 03 Aug 2012 09:00:48 -0700
Message-ID: <501BF5BC.5070209@mentor.com>
Date: Fri, 03 Aug 2012 13:01:00 -0300
From: Luis Gustavo <luis_gustavo@mentor.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Threads inheriting debug state from parent threads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: "Gustavo, Luis" <luis_gustavo@mentor.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I'm actually chasing a problem with GDB and hw watchpoints for embedded 
ppc targets.

If a thread X creates thread Y, is it expected that thread Y will 
inherit all the debug state from thread X? Including, for example, any 
hardware watchpoints/breakpoints that are set in thread X?

Thanks,
Luis
