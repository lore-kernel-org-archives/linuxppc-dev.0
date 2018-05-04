Return-Path: <ruscur@russell.cc>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40chyq0DsSzF15L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 16:32:50 +1000 (AEST)
Message-ID: <1525415564.2560.5.camel@russell.cc>
Subject: Re: [PATCH 05/13] powerpc/eeh: Strengthen types of eeh traversal
 functions
From: Russell Currey <ruscur@russell.cc>
To: Sam Bobroff <sbobroff@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 04 May 2018 16:32:44 +1000
In-Reply-To: <4d86d04e2c48a80e604e790c48d6a608c5d45498.1525242772.git.sbobroff@linux.ibm.com>
References: <cover.1525242772.git.sbobroff@linux.ibm.com>
 <4d86d04e2c48a80e604e790c48d6a608c5d45498.1525242772.git.sbobroff@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-02 at 16:35 +1000, Sam Bobroff wrote:
> The traversal functions eeh_pe_traverse() and eeh_pe_dev_traverse()
> both provide their first argument as void * but every single user
> casts
> it to the expected type.
> 
> Change the type of the first parameter from void * to the appropriate
> type, and clean up all uses.
> 
> Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>

Reviewed-by: Russell Currey <ruscur@russell.cc>
