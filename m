From: Remco Treffkorn <remco@rvt.com>
Reply-To: remco@rvt.com
To: stefan.eletzhofer@eletztrick.de, linuxppc-dev@lists.linuxppc.org
Subject: Re: Symbol versioning problem
Date: Tue, 16 Jul 2002 11:21:50 -0700
References: <200207101429.39539.remco@rvt.com> <20020715110417.A3630@gonzo.local>
In-Reply-To: <20020715110417.A3630@gonzo.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200207161121.50509.remco@rvt.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday 15 July 2002 02:04, Stefan Eletzhofer wrote:
...
> Hmm, compiled this kernel with no problems for my PowerBook. My gcc is a
> 2.4.95, depmod is 2.4.15. And it a grep of /proc/ksyms reveals
> c00180f8 __out_of_line_bug_R8b0fd3c5
>
> Wild guess: do you have
> CONFIG_MODVERSIONS=y
> in your .config?
>
> just my .02$ anyway :)
>

Yes. I even checked, to be sure :-)

Since there was no storm of "me too"s, I assume that it's my particular
system. I'll spend some time to figure it out, and will let you know...

Cheers,
Remco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
