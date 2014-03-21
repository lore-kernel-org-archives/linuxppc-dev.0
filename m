Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4FBC62C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Mar 2014 04:29:01 +1100 (EST)
Message-ID: <1395422919.26958.6.camel@smoke>
Subject: Re: [PATCH 00/18] powerpc/boot: 64bit little endian wrapper
From: Geoff Levand <geoff@infradead.org>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Date: Fri, 21 Mar 2014 10:28:39 -0700
In-Reply-To: <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
References: <1391788771-16405-1-git-send-email-clg@fr.ibm.com>
 <1395328213-19206-1-git-send-email-clg@fr.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cédric,

On Thu, 2014-03-20 at 16:09 +0100, Cédric Le Goater wrote:
> The following patchset adds support for 64bit little endian boot 
> wrapper. It is based on original code from Andrew Tauferner. 

I tested this on PS3 (64 bit BE) and found no regression.

Tested by: Geoff Levand <geoff@infradead.org>
