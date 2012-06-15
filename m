Return-Path: <telenn.barz@gmail.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0D88B70B1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 00:43:13 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so6083273pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 07:43:11 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 15 Jun 2012 16:43:06 +0200
Message-ID: <CAE2rjsQpZzMaJQrNQexy7kUSVR6F09Nsuxi6ueKiLAh=Hj-G4Q@mail.gmail.com>
Subject: Questions on Hugetlb for bookE and PHYS_64BIT
From: telenn barz <telenn.barz@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7b2ee08d9ae20304c283d5e1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b2ee08d9ae20304c283d5e1
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

CONFIG_PHYS_64BIT enables kernel support for larger than 32-bit physical
addresses. Is it this configuration option we have to enable for the
support of 36-bit real memory (as are capable the Freescale e500v2 or
e500mc cores family) ?

The Hugetlb patch for BookE (
https://lists.ozlabs.org/pipermail/linuxppc-dev/2011-June/091315.html)
seems to be surbordinated to CONFIG_PHYS_64BIT. Is there any good reason
why it is not supported when CONFIG_PHYS_64BIT is disabled ?

Thanks,
Telenn

--047d7b2ee08d9ae20304c283d5e1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>CONFIG_PHYS_64BIT enables kernel support for larger than 32-=
bit physical addresses. Is it this configuration option we have to enable f=
or the support of 36-bit real memory (as are capable the Freescale e500v2 o=
r e500mc cores family) ?<br>
<br>The Hugetlb patch for BookE (<a href=3D"https://lists.ozlabs.org/piperm=
ail/linuxppc-dev/2011-June/091315.html">https://lists.ozlabs.org/pipermail/=
linuxppc-dev/2011-June/091315.html</a>) seems to be surbordinated to CONFIG=
_PHYS_64BIT. Is there any good reason why it is not supported when CONFIG_P=
HYS_64BIT is disabled ?<br>
<br>Thanks,<br>Telenn<br>

--047d7b2ee08d9ae20304c283d5e1--
