Message-ID: <1073.81.137.83.225.1086854147.squirrel@www.solinno.co.uk>
In-Reply-To: <1086809994.3227.83.camel@localhost>
References: <1290.81.137.83.225.1086682323.squirrel@www.solinno.co.uk>
    <1086809994.3227.83.camel@localhost>
Date: Thu, 10 Jun 2004 08:55:47 +0100 (BST)
Subject: Re: [PATCH][RFC] have_residual_data()
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Hollis Blanchard" <hollisb@us.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hollis Blanchard said:
> On Tue, 2004-06-08 at 03:12, Leigh Brown wrote:
>
>> I just read Gustavo's email, and co-incidently have finally began
>> looking
>> again at my patches over the last couple of days to see about making
>> them good enough to submit.  To this end, please find attached a patch
>> to create a new inline function have_residual_data(), which looks like
>> this:
>>
>> static inline int have_residual_data(void) {
>> #if       defined(CONFIG_PREP_RESIDUAL)
>> 	return res && res->ResidualLength;
>> #else /* !defined(CONFIG_PREP_RESIDUAL) */
>> 	return 0;
>> #endif /* defined(CONFIG_PREP_RESIDUAL) */
>> }
>
> Sounds like a great idea. :) Without having time to read the whole
> patch, I think preferred style is:
>
> #if       defined(CONFIG_PREP_RESIDUAL)
> static inline int have_residual_data(void) {
> 	return res && res->ResidualLength;
> }
> #else /* !defined(CONFIG_PREP_RESIDUAL) */
> static inline int have_residual_data(void) {
> 	return 0;
> }
> #endif /* defined(CONFIG_PREP_RESIDUAL) */

Fair enough.   Thanks, Hollis.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
