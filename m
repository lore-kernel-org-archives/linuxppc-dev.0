Mime-Version: 1.0
Message-Id: <v04220832b4a09622fc4c@[192.168.0.1]>
In-Reply-To: <20000111090836.B1620@suse.de>
References: <20000108171526.B8126@suse.de>
 <v04220818b49df84590b1@[192.168.0.1]> <38785B2C.7807E8FD@wanadoo.fr>
 <20000109142900.A17353@suse.de> <v04220827b49fa1e99714@[192.168.0.1]>
 <20000111090836.B1620@suse.de>
Date: Mon, 10 Jan 2000 23:14:06 -0900
To: Olaf Hering <olh@suse.de>
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: write into OF tree like nvsetenv
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 11/1/2000 Olaf Hering wrote:

>  > in short we have 2 problems right now: 1) we cannot write to OF nvram
>  > from linux at the moment and 2) we cannot figure out WHAT to write to
>  > it...
>
>We will change this, at least the last. Who solve the first problem? :)

I think BenH said he was going to work on fixing nvsetenv so it will 
actually write the changes back (need to document the new nvram 
format).

how will you fix the latter problem?   from what Ben has told me its 
quite non trivial.


-- 
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
