Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 65440DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 15:55:44 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so2120856nfc
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 21:55:40 -0700 (PDT)
Message-ID: <528646bc0703122155w5eed66a0j7a8f0a243e7ad6ce@mail.gmail.com>
Date: Mon, 12 Mar 2007 22:55:40 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem in compiling a kernel module
In-Reply-To: <20070313043050.GB82243@server.idefix.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070312170030.GA5613@server.idefix.lan>
	<528646bc0703121136g628bcaf7if0ef36f87d27dc6b@mail.gmail.com>
	<20070313043050.GB82243@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/12/07, Matthias Fechner <idefix@fechner.net> wrote:
> Hello Grant,
>
> * Grant Likely <grant.likely@secretlab.ca> [12-03-07 12:36]:
> > Looks like you're trying to access inital data (which is freed after
> > module load) from regular code (which is not)
>
> is it possible to find the line of code with the address is these
> warnings?

somewhere in the 'cleanup_module' function.  I don't know how to
resolve function+offset to line number in .o files, but it can
probably be done with readelf.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
