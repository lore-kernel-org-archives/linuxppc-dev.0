Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHNBy31qtzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:57:46 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g6so5135052pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 12:57:46 -0700 (PDT)
Date: Thu, 19 Oct 2017 06:57:32 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 18/25] powerpc: check key protection for user page access
Message-ID: <20171019065732.670b426a@MiWiFi-R3-srv>
In-Reply-To: <1504910713-7094-27-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-27-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Sep 2017 15:45:06 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Make sure that the kernel does not access user pages without
> checking their key-protection.
>

Why? This makes the routines AMR/thread specific? Looks like
x86 does this as well, but these routines are used by GUP from
the kernel.

Balbir Singh.
