Return-Path: <codevana@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.232])
	by ozlabs.org (Postfix) with ESMTP id 14A0C67A05
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 08:13:07 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 36so511712wra
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 15:13:06 -0700 (PDT)
Message-ID: <7cb1293c0605181456p3c1726e2n56942dfbd4217f70@mail.gmail.com>
Date: Thu, 18 May 2006 14:56:31 -0700
From: "Srinivas Murthy" <codevana@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: PPC host with a PCI root-complex
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_123171_910140.1147989391677"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_123171_910140.1147989391677
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

We have a ppc host with a PCI root-complex across which there are multiple
PCI end points.

An application running on the ppc host reading one of the device memory
regions (not DMA access but direct CPU read) causes a parity error on the
PCI interface controller.

We think that the error should be propagated up as a machine-check which is
considered a non-recoverable system-wide error. However with multiple PCI
devices present we think that this is too generic and could be reduced to b=
e
a critical-error which could be recovered from.

Are there any other approaches/thoughts keeping in mind that this is PPC
host and we're running a PCI-rootcomplex interface?

Thanks,
_Srinivas

------=_Part_123171_910140.1147989391677
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>We have a ppc host with a PCI root-complex across which there are mult=
iple PCI end&nbsp;points.</div>
<div>&nbsp;</div>
<div>An application running on the ppc host&nbsp;reading one of the device =
memory regions (not DMA access but direct CPU read)&nbsp;causes a parity er=
ror on the PCI interface controller.</div>
<div>&nbsp;</div>
<div>We think that the error should be propagated up as a machine-check whi=
ch is considered a non-recoverable system-wide error. However with multiple=
 PCI devices present we think that this is too generic and could be reduced=
 to be a critical-error which could be recovered from.
</div>
<div>&nbsp;</div>
<div>Are there any other approaches/thoughts keeping in mind that this is P=
PC host and we're running a PCI-rootcomplex interface?</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>_Srinivas</div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_123171_910140.1147989391677--
