Mime-Version: 1.0
Message-Id: <v04220801b4cedf422882@[192.168.240.10]>
In-Reply-To: <0002151714050B.09337@argo.linuxcare.com.au>
References: <0002151714050B.09337@argo.linuxcare.com.au>
Date: Tue, 15 Feb 2000 12:13:14 +0100
To: linuxppc-dev@lists.linuxppc.org
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Re:my web page
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I have done a little web page describing the current state of kernel
>development for the powermac and how to get my rsync trees.  It's at
>http://linuxcare.com.au/paulus/kernels.html.  Let me know if there is
>anything I should explain better (or more).  :-)
>
>--
>Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
>+61 2 6262 8990 tel, +61 2 6262 8991 fax
>paulus@linuxcare.com.au, http://www.linuxcare.com.au/
>Linuxcare.  Support for the revolution.

This is a very helpfull page. It was needed since a lot of time.

Just somes remarks :

I think we need an "official" stable pmac/ppc version. It is not
always clear if the main kernel release version is good for us (and
in many cases it proved to be good for old hardware), or what is the
current mostly recommended official version for ppc architecture (for
example the last one really distributed .

This version may be distributed as just a diff file from the official
ftp.kernel.org stable version and a comment to what hardware is or is
not supported. I am bored to see a lot of binary stable kernels
distributed without corresponding sources, so please always let us
recompile our own kernel with our own set of options.

My second remark is that it is very difficult for us to know to whom
patches must be submited. In the past I have used several options :

- submit a patch to the author or maintener of the source I patch.
Not always possible because somes patches will impact several sources
maintained by several different people. This was shown as the most
efficient option when avail.
- submit patch to the main kernel list or main kernel mainteners. Not
always efficient because some patches that are not specific to the
pmac architecture are difficult to explain to the i386 centric main
kernel (for example edianess problems or hardware architecture
peculiarities).
- submit patch to the pmac or ppc kernel maintener (paulus and cort).

It is a problem for me to see theses tree kernels separated (pmac,ppc
and kernel.org) and sometime there are problems in synchronizing
them. For example I have seen some patches included in one of theses
kernels and lost in synchronisation. Or I have got some patch that
where never included and the kernel list plagged with complains about
exactly the same problem I was have submit a patch month ago.

So please, setup a page (for example on linuxppc.org or
www.ppc.kernel.org) to indicates to us, potential kernel supporters,
the simplest way of supporting ppc kernels.

Regards,

-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
