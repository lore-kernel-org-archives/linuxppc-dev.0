Return-Path: <dmitry.torokhov@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.206])
	by ozlabs.org (Postfix) with ESMTP id CEC2C67A7E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Jan 2005 04:34:15 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id a41so874531rng
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 09:34:14 -0800 (PST)
Message-ID: <d120d500050128093472935f8a@mail.gmail.com>
Date: Fri, 28 Jan 2005 12:34:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <d120d500050128084345bb1abd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050128132202.GA27323@suse.de> <20050128135827.GA28784@suse.de>
	<d120d50005012806435a17fe98@mail.gmail.com>
	<20050128145511.GA29340@suse.de>
	<d120d500050128072268a5c2f0@mail.gmail.com>
	<20050128161746.GA1092@suse.de>
	<d120d500050128084345bb1abd@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: atkbd_init lockup with 2.6.11-rc1
Reply-To: dtor_core@ameritech.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Jan 2005 11:43:44 -0500, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> This time  keyboard does not hang but NAKs everything instead...

Probably stupid question - does this box have AT keyboard? Or NAKs are
perfectly valid?

-- 
Dmitry
