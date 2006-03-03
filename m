Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id C261967A06
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 02:01:27 +1100 (EST)
Received: from White64 (p54B4AC50.dip0.t-ipconnect.de [84.180.172.80])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id k23F1kq17086
	for <linuxppc-embedded@ozlabs.org>; Fri, 3 Mar 2006 16:01:57 +0100
Date: Fri, 3 Mar 2006 16:01:27 +0100
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: boot failure on lite5200b board
Message-ID: <20060303160127.2f33d64c@White64>
In-Reply-To: <84A109BF918D934CB46ACF33BCE187C002D54D96@mail02.student.main.ntu.edu.sg>
References: <84A109BF918D934CB46ACF33BCE187C002D54D71@mail02.student.main.ntu.edu.sg>
	<43FD6669.9090405@246tNt.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D7A@mail02.student.main.ntu.edu.sg>
	<4b73d43f0602230818w63423513n817d9ec7eb580d2c@mail.gmail.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D7B@mail02.student.main.ntu.edu.sg>
	<4b73d43f0602240917h1d80bcf8ycc87086305434304@mail.gmail.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D94@mail02.student.main.ntu.edu.sg>
	<4b73d43f0603011652w39fb4393x8879891b7538f0b1@mail.gmail.com>
	<84A109BF918D934CB46ACF33BCE187C002D54D96@mail02.student.main.ntu.edu.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


It looks like, your mpc52xx fec is missing...

have you patched in the FEC Driver ?

>Am Fri, 3 Mar 2006 16:06:40 +0800 schrieb "#LI JIANGGAN#"
><lijianggan@pmail.ntu.edu.sg> :
>I couldn't figure out why error 101 /* Network is unreachable */ is
>given. Below is my current U-boot settings and a snapshot of the
>booting:
