Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sJG1f37YzzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Aug 2016 13:21:26 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so7385502pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 20:21:26 -0700 (PDT)
Subject: Re: [PATCH v5 04/13] powerpc: Factor out relocation code from
 module_64.c to elf_util_64.c.
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
References: <1470956898-5991-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <4126991.2tm6WB17SD@hactar> <3ca4a2de-0d44-dbc6-b57b-c149d10b048f@gmail.com>
 <4586138.sszncvQpYx@hactar>
Cc: kexec@lists.infradead.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Baoquan He <bhe@redhat.com>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Eric Biederman <ebiederm@xmission.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Young <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Vivek Goyal <vgoyal@redhat.com>, Oliver O'Halloran <oohall@gmail.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <239172a5-1952-de2d-e48d-4ca7d882356c@gmail.com>
Date: Tue, 23 Aug 2016 13:21:04 +1000
MIME-Version: 1.0
In-Reply-To: <4586138.sszncvQpYx@hactar>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> zImage on ppc64 BE is an ELF32 file. This patch set only supports loading 
> ELF files of the same class as the kernel, so a 64 bit kernel can't load an 
> ELF32 file. It would be possible to add such support, but it would be a new 
> feature.
> 
> The distros I was able to check on ppc64 LE and BE all use vmlinux.
> kexec-tools with kexec_load also doesn't support zImage. Do you think it is 
> important to support zImage?
> 

Well if it didn't work already, I think its low priority. Michael should be
able to confirm this. Oliver's been trying to cleanup the zImage to get rid
the old zImage limitation, cc'ing him

Balbir Singh
