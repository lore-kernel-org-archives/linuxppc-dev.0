Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C9A13B9.1060008@embeddededge.com>
Date: Thu, 21 Mar 2002 12:09:13 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Neil Horman <nhorman@lvl7.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Question regarding the clear_page function
References: <3C99D513.5740FDAF@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Horman wrote:

> .....  My question is, why is this not the case for the
> 8XX series as well?

The behavior of this instruction during faults and exceptions has often
been incorrect and the different silicon revisions behave differently.
Rather than track all of the different silicon variants, install and
test all of the patches, it is easier to just not use it.

> ....  I'm asking because I'm testing a modifed kernel in which
> we use the dcbz instruction rather than 4 stores, and we curious as to what
> consequences I might expect.

You are probably experiencing them :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
