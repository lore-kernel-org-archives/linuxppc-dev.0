Return-Path: <jirislaby@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by ozlabs.org (Postfix) with ESMTP id 91898DE048
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 23:44:00 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so2042405fkz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 06:43:58 -0700 (PDT)
Message-ID: <48035F98.1020404@gmail.com>
Date: Mon, 14 Apr 2008 15:43:52 +0200
From: Jiri Slaby <jirislaby@gmail.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] Driver for Freescale 8610 and 5121 DIU
References: <12053582234100-git-send-email-yorksun@freescale.com>	<12053582231281-git-send-email-yorksun@freescale.com>	<47D8572C.8090501@gmail.com>	<47FFDBFF.1030809@gmail.com>
	<20080411221817.0b1eb414.akpm@linux-foundation.org>
	<48035E93.6070300@freescale.com>
In-Reply-To: <48035E93.6070300@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	York Sun <yorksun@freescale.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 04/14/2008 03:39 PM, Timur Tabi wrote:
> Andrew Morton wrote:
> 
>> Thanks.  I've made a note that this patch has outstanding issues.  Usually
>> this means that I'll defer merging it until they have been addressed:
>> either by fixing them or by successfully arguing against the objections.  
> 
> Sorry, I must have gotten out of sync.  What are the outstanding issues?  I was
> under the impression that the latest patch (v5) resolved everything.  In fact,
> the last email from you (dated 4/1) said that you picked it up, minus the defconfig.

See
http://lkml.org/lkml/2008/3/12/375
