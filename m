Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 7774867A7B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 10:57:01 +1100 (EST)
Message-ID: <41F04548.4090205@mvista.com>
Date: Thu, 20 Jan 2005 16:56:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<20050118181330.GJ28724@smtp.west.cox.net>
	<41ED5C51.8020809@mvista.com>
	<20050118190848.GM28724@smtp.west.cox.net>
	<41ED66D0.2090506@mvista.com>
	<20050119180841.GP28724@smtp.west.cox.net>
	<41F01A23.2090907@mvista.com>
	<20050120225321.GB2626@smtp.west.cox.net>
	<41F03CEA.2030703@mvista.com>
	<20050120234708.GF2626@smtp.west.cox.net>
In-Reply-To: <20050120234708.GF2626@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

>I don't know how we talked past eachother, but it would look exactly
>like it did in your patch.  The only thing is that you don't ask the
>user, you make use of what the user told you already.  This is a nice
>new feature of the 2.6 kconfig system.  This is what I'm asking you to
>change from your first patch.
>

I don't know how we talked past each other either but as I wrote that 
last email, I realized that was what you had already suggested.  My bad 
& my apologies.

Mark
