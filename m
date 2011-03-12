Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0830B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 12:39:16 +1100 (EST)
Message-ID: <56927.94.211.195.167.1299893950.squirrel@gate.crashing.org>
In-Reply-To: <AANLkTinzpvV3Y7FXTPo8yPrE69CA1C1ejBMqC+O5o9zZ@mail.gmail.com>
References: <AANLkTinfxdckX=sYk5fX4vRhnmJNTHnytWkUW0w_HMj4@mail.gmail.com>
	<56564.94.211.195.167.1299875156.squirrel@gate.crashing.org>
	<AANLkTinzpvV3Y7FXTPo8yPrE69CA1C1ejBMqC+O5o9zZ@mail.gmail.com>
Date: Sat, 12 Mar 2011 02:39:10 +0100 (CET)
Subject: Re: ongoing mesh saga ...
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "kevin diggs" <diggskevin38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> make drivers/scsi/mesh.s
>>
> ??? I thought I have tried this in the past and it did not work? The
> make <path>/<file>.s thing?
>
> Thanks for the tip!

You need to have the driver in your kernel config, or things will
go weird.


Segher
