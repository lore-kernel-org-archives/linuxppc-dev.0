Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B729043.9080303@grandegger.com>
References: <1264685141-26391-1-git-send-email-wg@grandegger.com>
	<1264685141-26391-2-git-send-email-wg@grandegger.com>
	<fa686aa41002090941je3e4fdqbecf2616a8b90e42@mail.gmail.com>
	<4B7285D5.9060008@grandegger.com>
	<20100210213203.48a9105e.sfr@canb.auug.org.au>
	<4B729043.9080303@grandegger.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 10 Feb 2010 07:14:26 -0700
Message-ID: <fa686aa41002100614l76bff396ved847c0b0a4c71ff@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] i2c-mpc: use __devinit[data] for initialization
	functions and data
To: Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Devicetree-discuss@lists.ozlabs.org, Linux-i2c@vger.kernel.org,
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

On Wed, Feb 10, 2010 at 3:53 AM, Wolfgang Grandegger <wg@grandegger.com> wr=
ote:
> Stephen Rothwell wrote:
>> Hi Wolfgang,
>>
>> On Wed, 10 Feb 2010 11:09:25 +0100 Wolfgang Grandegger <wg@grandegger.co=
m> wrote:
>>>> __devinitdata goes at the end, immediately before the '=3D'. =A0Ditto
>>>> throughout the file.
>>> This made a difference and revealed section mismatches. "const" seems t=
o
>>> be incompatible with "__devinitdata".
>>
>> Maybe try no "const" and "__devinitconst" (I am not sure if both will
>> work).
>
> Yes, that works, even together with "const". To avoid rolling out the
> whole patch series again, I can prepare a follow-up patch fixing this iss=
ue.

Nah, just resend this one patch.

g.
