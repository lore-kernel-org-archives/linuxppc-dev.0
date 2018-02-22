Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn0Sx2lTbzDr33
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 14:38:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Mark Lord <mlord@pobox.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kees Cook <keescook@chromium.org>, linuxppc-dev@lists.ozlabs.org,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>
Subject: Re: [PATCH] bpf, powerpc: fix jit for seccomp_data access
In-Reply-To: <1519221778.inx201t3s9.naveen@linux.ibm.com>
References: <d79074fe-2ee1-c132-ef2d-f6bb618b53bb@pobox.com>
 <2a91fe0c-ea85-dd79-6682-66b1301d7e49@iogearbox.net>
 <53a6b85c-8cb7-d4d0-8234-7ecfb1a709b2@pobox.com>
 <1519154571.d9vaokens9.naveen@linux.ibm.com>
 <2f428cf9-23f3-d1f1-1524-46d6faa17386__30848.5239781023$1519169515$gmane$org@pobox.com>
 <1519201713.vxxqmwxkkx.naveen@linux.ibm.com>
 <32a60518-1de6-9f9c-b3e6-5e5292d6b289@pobox.com>
 <2e79ef59-1731-f3a5-9868-c15beb939142@pobox.com>
 <1519221778.inx201t3s9.naveen@linux.ibm.com>
Date: Thu, 22 Feb 2018 14:38:56 +1100
Message-ID: <878tblr8vj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> Mark Lord wrote:
>> On 18-02-21 07:52 AM, Mark Lord wrote:
>>> On 18-02-21 03:35 AM, Naveen N. Rao wrote:
>> ..
>>>> Looks good to me, but I am not able to apply this patch. There seems to be whitespace damage.
>>> 
>>> Here (attached) is a clean copy.
>> 
>> Again, this time with the commit message included!
>
> Thanks. However...
> I am able to apply this using 'patch', but not with 'git am' since the 
> headers are missing. FWIW, the usual workflow is to make the changes and 
> commit it into your repository using 'git commit' and then use 'git 
> format-patch' to generate a patch file that you can then post.
>
> I'll defer to Michael on whether he is ok to process this as it is.

The main thing is that it's caught by patchwork[1], otherwise I tend to
miss it. In this case the initial patch was caught by patchwork, so
that's fine.

I fixed up the white space and other issues before applying.

In general I'm happy to do that for new/infrequent committers, not so
much for people who send lots of patches and/or are paid to do so :)

cheers

1: http://patchwork.ozlabs.org/patch/875890/
