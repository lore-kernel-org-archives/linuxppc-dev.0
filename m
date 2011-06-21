Return-Path: <jgpobox@gmail.com>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F089CB6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 06:39:17 +1000 (EST)
Received: by qyk9 with SMTP id 9so2347763qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 13:39:14 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4E010170.9050901@pobox.com>
Date: Tue, 21 Jun 2011 16:39:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH] libata/sas: only set FROZEN flag if new EH is supported
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
	<20110615233417.GB6324@us.ibm.com>
	<20110616075114.GH8141@htj.dyndns.org>
	<4DFA0507.3090609@linux.vnet.ibm.com>
	<20110616152836.GA15268@us.ibm.com>
	<20110621160714.GA14174@us.ibm.com>
	<4E00FF58.7070802@linux.vnet.ibm.com>
In-Reply-To: <4E00FF58.7070802@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: wayneb@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, mbizon@freebox.fr,
	Tejun Heo <tj@kernel.org>, Nishanth Aravamudan <nacc@us.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2011 04:30 PM, Brian King wrote:
> Looks good to me. Jeff/Tejun - any issues with merging this?

Looks good here too -- though of course we want to move towards purging 
old-EH paths :)

Queued...
