Return-Path: <wg@grandegger.com>
Message-ID: <4B729043.9080303@grandegger.com>
Date: Wed, 10 Feb 2010 11:53:55 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>	<1264685141-26391-2-git-send-email-wg@grandegger.com>	<fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>	<4B7285D5.9060008@grandegger.com>
	<20100210213203.48a9105e.sfr@canb.auug.org.au>
In-Reply-To: <20100210213203.48a9105e.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Devicetree-discuss@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
	Ben Dooks <ben-linux@fluff.org>, Linuxppc-dev@lists.ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Wolfgang,
> 
> On Wed, 10 Feb 2010 11:09:25 +0100 Wolfgang Grandegger <wg@grandegger.com> wrote:
>>> __devinitdata goes at the end, immediately before the '='.  Ditto
>>> throughout the file.
>> This made a difference and revealed section mismatches. "const" seems to
>> be incompatible with "__devinitdata".
> 
> Maybe try no "const" and "__devinitconst" (I am not sure if both will
> work).

Yes, that works, even together with "const". To avoid rolling out the
whole patch series again, I can prepare a follow-up patch fixing this issue.

Wolfgang.
