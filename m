Return-Path: <leon.woestenberg@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D61EEB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 02:54:31 +1000 (EST)
Received: by pzk26 with SMTP id 26so1034084pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 07 Apr 2011 09:54:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4D9D7575.1030200@ge.com>
References: <BANLkTimXgi26RHHxyBLoN8YqaDy_PL-hGQ@mail.gmail.com>
	<4D9D7575.1030200@ge.com>
Date: Thu, 7 Apr 2011 18:54:28 +0200
Message-ID: <BANLkTikf-LEL6hM_d8dbSA7C3YWbZGsTOw@mail.gmail.com>
Subject: Re: known working sata_sil24.c setup on powerpc platforms?
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Martyn Welch <martyn.welch@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Martyn,

thanks for a confirmation.

On Thu, Apr 7, 2011 at 10:27 AM, Martyn Welch <martyn.welch@ge.com> wrote:
> On 06/04/11 18:00, Leon Woestenberg wrote:
>>
>> Does anyone know of a working setup of sata_sil24 on a big endian
>> powerpc system?
>
> Yes, I think we even use it on a p2020 board, though I think our current
> kernel on that product is 2.6.34.
>
Could you check if that's using MSI or legacy interrupting on PCIe?

Thanks in advance for the effort,

Regards,
-- 
Leon
