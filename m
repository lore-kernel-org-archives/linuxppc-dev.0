Message-Id: <v04003a01b6ed50bf1d86@[24.70.162.12]>
In-Reply-To: <20010401200959.23374@smtp.wanadoo.fr>
References: <v04003a00b6ed2078c77d@[24.70.162.12]>
 <v04003a00b6ed2078c77d@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 1 Apr 2001 16:45:18 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: Fwd: CPU features
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:09 PM -0500 4/1/2001, Benjamin Herrenschmidt wrote:
>>
>>I got the linux-2.4-benh from rsync.penguinppc.org (I assume this is the
>>up-to-date one) around noontime today, and got a crash after arch:exit on
>>my 9600/200mp.
>
>I fixed that. Maybe the rsync is not fully up-to-date, I'll check that asap.

Ok, that crash appears to be fixed now.

Now after arch:exit, it just... stops. Cmd-power doesn't bring up xmon, so
I have no idea where it's died.

The sti replacement code still looked kinda weird, but I have no idea what
it's supposed to look like, so I guess that's ok...


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
