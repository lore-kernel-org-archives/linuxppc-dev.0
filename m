Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjR975J4HzDwRJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:26:35 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id y68so8363157pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 21:26:35 -0800 (PST)
Subject: Re: [PATCH v3 2/5] powerpc/mm: refactor
 {create,remove}_section_mapping()
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-3-git-send-email-arbab@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <21e60c5f-d864-9b51-2a40-da2d84956752@gmail.com>
Date: Tue, 20 Dec 2016 16:26:22 +1100
MIME-Version: 1.0
In-Reply-To: <1481831443-22761-3-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/16/2016 06:50 AM, Reza Arbab wrote:
> Change {create,remove}_section_mapping() to be wrappers around functions
> prefixed with "hash__".
>
> This is preparation for the addition of their "radix__" variants. No
> functional change.
>
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>

Acked-by: Balbir Singh <bsingharora@gmail.com>
