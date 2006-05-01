Return-Path: <codevana@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.235])
	by ozlabs.org (Postfix) with ESMTP id A49AC67BC3
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 07:25:59 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i3so24774wra
	for <linuxppc-dev@ozlabs.org>; Mon, 01 May 2006 14:25:57 -0700 (PDT)
Message-ID: <7cb1293c0605011425w1cc34197h4d5fa73ad1077d5a@mail.gmail.com>
Date: Mon, 1 May 2006 14:25:57 -0700
From: "Srinivas Murthy" <codevana@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: ioremap
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_22309_19516944.1146518757362"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_22309_19516944.1146518757362
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
 Why does ioremap() not allow normal system RAM to be mapped in using
ioremap().

 We have a need to access a portion of the normal system RAM to be mapped i=
n
non-cached.

 To simulate, I used kmalloc() to allocate the memory and then passed the
virt_to_phys() of the memory to ioremap() but then noticed that ioremap()
wont allow it.

 Is there another way to access this memory non-cached?

Regards,
_Srinivas

------=_Part_22309_19516944.1146518757362
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;Why does ioremap() not allow normal system RAM to be mapped in u=
sing ioremap().</div>
<div>&nbsp;</div>
<div>&nbsp;We have a need to access&nbsp;a portion of the normal system RAM=
 to be mapped in non-cached.</div>
<div>&nbsp;</div>
<div>&nbsp;To simulate, I used kmalloc() to allocate the memory and then pa=
ssed the virt_to_phys() of the memory to ioremap() but then noticed that io=
remap() wont allow it.</div>
<div>&nbsp;</div>
<div>&nbsp;Is there another way to access this memory non-cached?</div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>_Srinivas</div>
<div>&nbsp;</div>

------=_Part_22309_19516944.1146518757362--
