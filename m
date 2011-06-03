Return-Path: <zajec5@gmail.com>
Received: from mail-qy0-f177.google.com (mail-qy0-f177.google.com
	[209.85.216.177]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8100EB6FB8
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Jun 2011 07:24:58 +1000 (EST)
Received: by qyl38 with SMTP id 38so1352205qyl.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Jun 2011 14:24:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTinSdDZv7gshYfi4mK5N9K-E7vk3Yw@mail.gmail.com>
References: <1306918871-16965-1-git-send-email-zajec5@gmail.com>
	<BANLkTinSdDZv7gshYfi4mK5N9K-E7vk3Yw@mail.gmail.com>
Date: Fri, 3 Jun 2011 23:24:54 +0200
Message-ID: <BANLkTinq-Rn1zaS06ki4OD7DDV42bME-2Q@mail.gmail.com>
Subject: Re: [RFT][PATCH 3.0] ssb: fix PCI(e) driver regression causing oops
	on PCI cards
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To: linux-wireless@vger.kernel.org,
	=?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>,
	"John W. Linville" <linville@tuxdriver.com>,
	Andreas Schwab <schwab@linux-m68k.org>
Content-Type: multipart/alternative; boundary=0016368319a08cc66504a4d562e1
Cc: linuxppc-dev@ozlabs.org, b43-dev@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016368319a08cc66504a4d562e1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Jun 1, 2011 9:14 PM, "Rafa=C5=82 Mi=C5=82ecki" <zajec5@gmail.com> wrote:
>
> 2011/6/1 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com>:
> > We were incorrectly executing PCIe specific workarounds on PCI cards.
> > This resulted in:
> > Machine check in kernel mode.
> > Caused by (from SRR1=3D149030): Transfer error ack signal
> > Oops: Machine check, sig: 7 [#1]
>
> John, I've tested this patch myself on my PCI BCM4318, including
> checking for 0xFFFFFFFF reads in MMIO dumps.
>
> The patch is correct, please take it for 3.0.

Ping, ping, ping John.

--0016368319a08cc66504a4d562e1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p><br>
On Jun 1, 2011 9:14 PM, &quot;Rafa=C5=82 Mi=C5=82ecki&quot; &lt;<a href=3D"=
mailto:zajec5@gmail.com">zajec5@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; 2011/6/1 Rafa=C5=82 Mi=C5=82ecki &lt;<a href=3D"mailto:zajec5@gmail.co=
m">zajec5@gmail.com</a>&gt;:<br>
&gt; &gt; We were incorrectly executing PCIe specific workarounds on PCI ca=
rds.<br>
&gt; &gt; This resulted in:<br>
&gt; &gt; Machine check in kernel mode.<br>
&gt; &gt; Caused by (from SRR1=3D149030): Transfer error ack signal<br>
&gt; &gt; Oops: Machine check, sig: 7 [#1]<br>
&gt;<br>
&gt; John, I&#39;ve tested this patch myself on my PCI BCM4318, including<b=
r>
&gt; checking for 0xFFFFFFFF reads in MMIO dumps.<br>
&gt;<br>
&gt; The patch is correct, please take it for 3.0.</p>
<p>Ping, ping, ping John.</p>

--0016368319a08cc66504a4d562e1--
