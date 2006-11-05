Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.174])
	by ozlabs.org (Postfix) with ESMTP id 9839667C1A
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Nov 2006 13:32:13 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so569629ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 04 Nov 2006 18:32:12 -0800 (PST)
Message-ID: <528646bc0611041832j327c8391i9d3401782529073d@mail.gmail.com>
Date: Sat, 4 Nov 2006 20:32:11 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: linuxppc-embedded@ozlabs.org, "Matthias Fechner" <idefix@fechner.net>
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running?
In-Reply-To: <20061104163119.GC69112@server.idefix.loc>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20061104163119.GC69112@server.idefix.loc>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 11/4/06, Matthias Fechner <idefix@fechner.net> wrote:
> Hi,
>
> I have here a MPC5200 Lite (IceCube/Freescale Lite 5200) and tried to
> get Xenomai running.
>
> If I use the 2.6 kernel from denx the board boots fine but I am not
> able to patch the kernel with the adeos patch (adeos-patch is for
> kernel 2.6.18) and the kernel from denx is 2.6.19rc4. I checked the
> changes and they are to much for me to adapt it.
>
> What I need now is a patch for kernel 2.6.18 to get all the MPC5200
> stuff running (priority has the networkchip) or a adeos patch for the
> denx kernel 2.6.19-rc4.
>
> Can anyone help me here, please?

Yup, there exists patches for all the functionality that you're
looking for.  You can find them if you search the list, but I'll send
you a link to a git tree with all those patches in it later tonight.

Cheers
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
