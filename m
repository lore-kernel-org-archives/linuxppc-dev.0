Subject: Re: ppc405
From: Honza Petrous <hop@unibase.cz>
To: j.rakesh@gdatech.co.in
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <d1meaw1bmx51kfr.050820031511@gda-server>
References: <3rei6m2mr5lqbm8.050820030924@gda-server>
	 <nm21sxj6y0pv70g.050820031234@gda-server>
	 <1060068122.21574.6.camel@elrond.unibase.cz>
	 <d1meaw1bmx51kfr.050820031511@gda-server>
Content-Type: text/plain; charset=ISO-8859-2
Message-Id: <1060080131.22522.40.camel@elrond.unibase.cz>
Mime-Version: 1.0
Date: 05 Aug 2003 12:42:11 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


V Út, 05. 08. 2003 v 11.51, Rakesh jagota napsal:
> Thanks a lot. It seems X11 is required for this browser.
> Is there any browser without X11 libraries.
>

See more deeply in configure.sh - there is possibility
to not use X at all ;) Then it will act in full-screen
textmode only.

/Honza


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
