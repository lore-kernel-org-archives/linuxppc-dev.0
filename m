From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200110241902.f9OJ27U30968@hofr.at>
Subject: Re: microcodepatch
In-Reply-To: <EADB10BAC266A14A85ECBF8686A73E3145934F@kolkrabbi.flaga.is> from
 =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= at "Oct 24, 2001 06:50:20 pm"
To: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kd@flaga.is>
Date: Wed, 24 Oct 2001 21:02:07 +0200 (CEST)
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Hi,
>
> Are there any known issues regarding the I2C patch and the ethernet
> driver?
>
> If I disable the microcode patch everything works fine, except the I2C
> stuff.
>
> I am using the linuxppc_2_4_devel tree ported to our custom board with
> ehternet on SCC2.
>
> Regards,
>
there might be - the dual-ported RAM of the CPM is quite limited and the micro-code goes in there - might be that the BD's for the SCC/ethernet are overlapping ??

hofrat

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
