Date: Tue, 4 Dec 2001 11:35:21 -0500 (EST)
From: Christopher Murtagh <christopher.murtagh@mcgill.ca>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Max swap size ?
In-Reply-To: <1007482452.21511.10.camel@pismo>
Message-ID: <Pine.LNX.4.33.0112041131460.28164-100000@blues.wcg.mcgill.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Thanks for the replies.

On 4 Dec 2001, Michel Dänzer wrote:
>That used to be the case before kernel 2.2 IIRC. Nowadays the limit is
>in the gigabytes. FWIW I'm using a 400 meg swap partition without
>problems.

 Ok, well that's good to hear.

>Are you sure it only hit swap then? I can't remember ever seeing active
>but completely unused swap space, even when RAM usage was low.
>
>The bottom line is yes, you likely have another problem.

 This isn't though.. :-(

Mem:  1024100K av,  774636K used,  249464K free,  0K shrd,  179708K  buff
Swap:  524280K av,       0K used,  524280K free             490400K  cached

 this is what my machine is like at the moment. So, from what you are
saying, my problem lies elsewhere (ie. is not swap *size*), but is likely
swap related? Is there a way I can force swapping in an elegant way to
test whether this will bring down my machine? Thanks again.

Cheers,

Chris


--

Christopher Murtagh
Webmaster / Sysadmin
Web Communications Group
McGill University
Montreal, Quebec
Canada

Tel.: (514) 398-3122
Fax:  (514) 398-2017


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
