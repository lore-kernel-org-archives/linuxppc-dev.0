Subject: Re: /proc problem
From: "Guy M. Streeter" <streeter@redhat.com>
To: t.vanremortel@ha.be
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <1066306828.735.29.camel@toni>
References: <1066306828.735.29.camel@toni>
Content-Type: text/plain
Message-Id: <1066313452.1033.1.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 16 Oct 2003 09:10:52 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You're trying to do floating-point math. The kernel doesn't do
floating-point.

--Guy

On Thu, 2003-10-16 at 07:20, Toni Van Remortel wrote:
> Hi all,
>
> I just added some /proc support to my module to run on an EP405, but
> when I load my module, I get
> unresolved symbol __extendsfdf2
> Google didn't get me any further.
> Code can be found at http://linemb.d-sciencelab.com/rt_mod.c
>
> Thanks,
> --
>                            Toni Van Remortel
>               Wetenschappelijk Medewerker - D-science lab
>   Real time Linux for embedded systems: http://linemb.d-sciencelab.com
>               Tel: +32 3 205 61 72 - Fax: +32 3 205 61 95
>                       E-mail: t.vanremortel@ha.be
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
