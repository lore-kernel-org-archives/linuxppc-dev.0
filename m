Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A89ADB6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 30 Jun 2010 02:52:09 +1000 (EST)
In-Reply-To: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
References: <AANLkTimV1AFEUrRf-2iEizXH4HQFMrrAumsRVDKxNfAv@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <356261A9-B09F-4E82-A897-FD0724C503F4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: kernel init exception
Date: Tue, 29 Jun 2010 18:51:16 +0200
To: "wilbur.chan" <wilbur512@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> why there generated a signal 4  in  init  process?

That's SIGILL; sounds like you compiled init with the wrong (sub-)arch
or cpu flags.


Segher
