Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.238])
	by ozlabs.org (Postfix) with ESMTP id 45E1CDDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 09:08:15 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1386819nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 16:08:14 -0700 (PDT)
Message-ID: <fa686aa40710161608q1f7bd5aakee0e124a194f918@mail.gmail.com>
Date: Tue, 16 Oct 2007 17:08:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Andreas Schwab" <schwab@suse.de>
Subject: Re: [PATCH 1/2] bootwrapper: Allow wrapper script to execute verbosely
In-Reply-To: <jeejfuae27.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071016213101.14117.43657.stgit@trillian.cg.shawcable.net>
	<jeejfuae27.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/16/07, Andreas Schwab <schwab@suse.de> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
> > +# Allow for verbose output
> > +if [ "$V" == "1" ]; then
>
> The correct syntax is [ a = b ] (and the quotes around 1 are not needed,
> btw.).

heh; I guess I'm not much of a shell programmer.  :-)

I'll respin this patch.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
