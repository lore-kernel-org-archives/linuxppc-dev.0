Message-ID: <63605.192.43.227.18.1086055525.squirrel@www.toojays.net>
In-Reply-To: <1086047232.1930.74.camel@gaston>
References: <200405302331.35357.toojays@toojays.net>
    <200405311003.21439.toojays@toojays.net>
    <1085975390.1930.31.camel@gaston>
    <200405311807.59356.toojays@toojays.net>
    <1086047232.1930.74.camel@gaston>
Date: Tue, 1 Jun 2004 11:35:25 +0930 (CST)
Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with
     7447Acpu
From: "John Steele Scott" <toojays@toojays.net>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: "John Steele Scott" <toojays@toojays.net>,
	"linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>,
	"Christiaan Welvaart" <cjw@daneel.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Oh, and when switching to high speed, think about tweaking the
> voltage too. I don't know if it's high or low when setting the
> GPIO bit, you may want to check out OF code, it certainly have
> methods for that. Or you can read the voltage value back from
> the adt themometer chip I think, as it does voltage control.

I will double-check this tonight (am at uni now), but I thought that the
core voltage for this chip does not change with frequency . . . :(

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
