From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Error calling timer_create
Date: Wed, 19 May 2004 08:52:58 +0200
References: <200405190509.PAA20836@sprint.tenix.com>
In-Reply-To: <200405190509.PAA20836@sprint.tenix.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405190852.58747.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

ENOSYS means, that the function is not implemented on your system, probaly
your glibc is somwhat outdatet. I remember the same thing here some time
ago before using glibc-2.2.5. Updating your CDK should help.

Ciao,
  Gerhard

On Wednesday 19 May 2004 07:09, MERRITT Nigel wrote:
[SNIPSNAP]
> // Initialise the timer.
> if (timer_create(CLOCK_REALTIME, &stEvent, &nTimerId))
> {
>    printf("Timer could not be created (err=%d).\n", errno);
>    return -1;
> }
> .
> .
> .
>
> ... with the result:
>
>    Timer could not be created (err=38).
>
> The code obviously compiles so I can't work out why it would claim the
> function does not exist.  The code is compiled with static linking so all
> libraries should be included in the executable.
>
> Any help would be appreciated...
>
>    NJM


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
