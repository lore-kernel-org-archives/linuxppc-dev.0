From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15612.33453.511232.700368@argo.ozlabs.ibm.com>
Date: Tue, 4 Jun 2002 19:04:45 +1000 (EST)
To: laurent.mohin@acterna.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: C++ style comments
In-Reply-To: <C1256BCE.0026019D.00@magnus.eni.wago.de>
References: <C1256BCE.0026019D.00@magnus.eni.wago.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


laurent.mohin@acterna.com writes:

> Just a general question.
> I saw in several previous issues that we should avoid using C++
> style comments.
> Why?

In the past they have been deprecated because they were not officially
part of the C language.  These days they are.  However, although they
are allowed, they are regarded as being in somewhat bad taste by many
kernel hackers.  I personally think they look a little ugly.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
